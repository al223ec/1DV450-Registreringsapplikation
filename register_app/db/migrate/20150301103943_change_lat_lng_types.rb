class ChangeLatLngTypes < ActiveRecord::Migration
  def change
     change_column :positions, :lat, :float
     change_column :positions, :lng, :float
  end
end
