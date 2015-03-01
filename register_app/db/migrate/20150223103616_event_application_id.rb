class EventApplicationId < ActiveRecord::Migration
  def change
	change_table :events do |t|
  		t.references :application, index: true
	   	add_foreign_key :events, :applications
  	end
  end
end
