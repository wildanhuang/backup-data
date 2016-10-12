class Profile < ActiveRecord::Base
  has_many :profile_details, dependent: :destroy
  has_many :backup_files, dependent: :destroy

  validate :check_file_or_directory

  after_create :backup_records
  after_update :update_records

  private
    def check_file_or_directory
      unless (Dir.entries(self.folders) rescue false)
        errors.add("Error", ": No such file or directory" )
      end
    end

    def backup_records
      profile_detail = self.profile_details.create
      BackupGenerator::Process.backup(self.id, self.folders, self.exclusion, 'create', profile_detail.id)
    end

    def update_records
      profile_detail = self.profile_details.create
      self.backup_files.update_all(is_new: nil) if self.backup_files.present?
      BackupGenerator::Process.backup(self.id, self.folders, self.exclusion, 'update', profile_detail.id)
    end
end
