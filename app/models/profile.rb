class Profile < ActiveRecord::Base
  has_many :backup_files, dependent: :destroy

  validate :check_file_or_directory
  after_create :backup_records

  private
    def check_file_or_directory
      unless (Dir.entries(self.folders) rescue false)
        errors.add("Error", ": No such file or directory" )
      end
    end

    def backup_records
      BackupGenerator::Process.backup(self.id, self.folders)
    end
end
