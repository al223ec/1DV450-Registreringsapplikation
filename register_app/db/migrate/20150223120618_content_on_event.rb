class ContentOnEvent < ActiveRecord::Migration
  def change
	change_table :events do |t|
		t.text :content
	end
  end
end
