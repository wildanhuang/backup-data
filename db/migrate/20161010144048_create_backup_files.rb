class CreateBackupFiles < ActiveRecord::Migration
  def change
    create_table :backup_files do |t|
      t.integer :profile_id
      t.string  :file_url
      t.string  :file

      t.timestamps null: false
    end
  end
end
