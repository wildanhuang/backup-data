class CreateProfiles < ActiveRecord::Migration
  def change
    create_table :profiles do |t|
      t.string  :name
      t.string  :folders
      t.string  :exclusion

      t.timestamps null: false
    end
  end
end
