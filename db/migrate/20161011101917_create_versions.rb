class CreateVersions < ActiveRecord::Migration
  def change
    create_table :versions do |t|
      t.integer :backup_file_id
      t.string  :file

      t.timestamps null: false
    end
  end
end
