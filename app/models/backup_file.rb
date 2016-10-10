class BackupFile < ActiveRecord::Base
  mount_uploader :file, RecordUploader
  
  belongs_to :profile
end
