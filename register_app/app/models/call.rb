class Call < ActiveRecord::Base
  	belongs_to :application
	default_scope -> { order(created_at: :desc) }
  	validates :application_id, presence: true

  	validate :prevent_update, on: :update #Tanken är att man inte får uppdatera denna model med nytt data

	private
		def prevent_update
			errors.add(:call_id, "Not allowed to update this post")
		end
end
