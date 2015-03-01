class ApiUsers < ActiveRecord::Migration
  def change
  	change_table :applications do |t|
		t.remove :user_id

  		t.references :api_user, index: true
    end
  end
end
