class Profile < ActiveRecord::Base
  has_many :backup_files
  
  validate :check_file_or_directory
  before_save :backup_files

  def backup_files
    folder = self.folders
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
      # backup
    end

    if folders.present?
      # repeat function
    end
  end

  private
    def check_file_or_directory
      unless (Dir.entries(self.folders) rescue false)
        errors.add("Error", ": No such file or directory" )
      end
    end
end
