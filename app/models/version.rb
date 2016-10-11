class Version < ActiveRecord::Base
  mount_uploader :file, RecordUploader
  
  belongs_to :backup_file
end
