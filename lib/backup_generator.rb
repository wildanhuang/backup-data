module BackupGenerator
  class Process
    def self.backup(profile_id, folder)
      profile = Profile.find_by(id: profile_id)
      folders = []
      files = []

      Dir.entries(folder).select {|entry| !(entry =='.' || entry == '..') }.each do |entry|
        file = File.join(folder, entry)
        if File.directory? file
          folders << file
        else
          files << file
        end
      end

      if files.present?
        # backup files
        files.each do |file|
          profile.backup_files.create(file_url: file, file: Pathname.new(file).open)
        end
      end

      if folders.present?
        # repeat function
        folders.each do |data|
          BackupGenerator::Process.backup(profile_id, data)
        end
      end
    end
  end
end