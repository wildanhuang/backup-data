module BackupGenerator
  class Process
    def self.backup(profile_id, folder, exclusion=nil, action=nil)
      profile = Profile.find_by(id: profile_id)

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
            end
          else
            profile.backup_files.create(file_url: file, file: Pathname.new(file).open)
          end
          
        end
      end

      if folders.present?
        # repeat function
        folders.each do |data|
          BackupGenerator::Process.backup(profile_id, data, profile.exclusion, action)
        end
      end
    end
  end
end