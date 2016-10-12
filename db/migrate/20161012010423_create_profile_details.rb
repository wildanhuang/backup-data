class CreateProfileDetails < ActiveRecord::Migration
  def change
    create_table :profile_details do |t|
      t.integer :profile_id
      t.integer :new_files, default: 0
      t.integer :updated_files, default: 0

      t.timestamps null: false
    end
  end
end
