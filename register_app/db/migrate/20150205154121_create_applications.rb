class CreateApplications < ActiveRecord::Migration
  def change
    create_table :applications do |t|
      t.string :key
      t.string :name
      t.references :user, index: true

      t.timestamps null: false
    end
 	add_index :applications, [:user_id, :created_at]
  end
end
