class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.string :lat
      t.string :lng

      t.timestamps null: false
    end
  end
end
