class AddLocationToPosition < ActiveRecord::Migration
  def change
    change_table :positions do |t|
      t.text :street
      t.text :city
      t.text :state
      t.text :country
    end
  end
end
