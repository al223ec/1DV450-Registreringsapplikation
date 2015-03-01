class CreateCalls < ActiveRecord::Migration
  def change
    create_table :calls do |t|
      t.text :ip
      t.text :caller
      t.references :application, index: true

      t.timestamps null: false
    end
    	add_foreign_key :calls, :applications
    	add_index :calls, [:application_id, :created_at]
  end
end
