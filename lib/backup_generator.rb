module BackupGenerator
  class Process
    def self.backup(profile_id, folder, exclusion, action, profile_detail_id)
      profile = Profile.find_by(id: profile_id)
      profile_detail = profile.profile_details.find_by(id: profile_detail_id)

      folders = []
      files = []

      Dir.entries(folder).select {|entry| !(entry =='.' || entry == '..') }.each do |entry|
        file = File.join(folder, entry)
        
        if exclusion.present?
          next if file == exclusion || file.include?(exclusion)
        end

        if File.directory? file
          folders << file
        else
          files << file
        end
      end

      if files.present?
        # backup files
        files.each do |file|
          if action == 'update'
            backup_file = profile.backup_files.find_by(file_url: file)
            new_file = Pathname.new(file).open
            old_file = Pathname.new(backup_file.file.path).open
            flag = FileUtils.compare_file(old_file, new_file)

            unless flag
              # create new version
              backup_file.versions.create(file: old_file)
              backup_file.update_attributes(file: new_file, is_new: false)
              profile_detail.updated_files += 1
            end
          else
            profile.backup_files.create(file_url: file, file: Pathname.new(file).open)
            profile_detail.new_files += 1
          end
        end
        profile_detail.save
      end

      if folders.present?
        # repeat function
        folders.each do |data|
          BackupGenerator::Process.backup(profile_id, data, profile.exclusion, action, profile_detail_id)
        end
      end
    end
  end
end