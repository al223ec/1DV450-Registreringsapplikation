class CorrectionPosition < ActiveRecord::Migration
  def change
	change_table :events do |t|
		t.remove :postion_id

		t.references :position, index: true
		add_foreign_key :events, :positions
	end
  end
end
