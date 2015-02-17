class CreatePositions < ActiveRecord::Migration
  def change
    create_table :positions do |t|
      t.decimal :lat
      t.decimal :lng

      t.timestamps null: false
    end
	
	change_table :events do |t|
		t.references :postion, index: true

 		remove_column :events, :lat
 		remove_column :events, :lng

    	add_foreign_key :events, :positions
  	end
  end
end
