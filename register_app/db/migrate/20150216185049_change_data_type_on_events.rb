class ChangeDataTypeOnEvents < ActiveRecord::Migration
  def change
		change_table :events do |t|
    		t.change  :lat, :decimal
      		t.change :lng, :decimal
    end
  end
end
