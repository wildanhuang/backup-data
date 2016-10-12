class AddIsNewToBackupFiles < ActiveRecord::Migration
  def change
    add_column :backup_files, :is_new, :boolean, default: true
  end
end
