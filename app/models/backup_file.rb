class BackupFile < ActiveRecord::Base
  mount_uploader :file, RecordUploader

  has_paper_trail :on => [:create, :update],
                  :only => [:file]

  belongs_to :profile
end
