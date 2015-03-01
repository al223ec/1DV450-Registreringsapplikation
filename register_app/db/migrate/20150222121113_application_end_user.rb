class ApplicationEndUser < ActiveRecord::Migration
  def change
  	change_table :users do |t|
  		t.references :application, index: true
	   	add_foreign_key :users, :applications
  	end
  end
end
