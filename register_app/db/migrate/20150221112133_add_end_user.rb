class AddEndUser < ActiveRecord::Migration
  def change
	change_table :events do |t|
  		t.references :end_user, index: true
	   	add_foreign_key :events, :end_users
  	end
    add_index :events, [:end_user_id, :created_at]
  end
end
