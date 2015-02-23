class EndUser < User
	has_many :events
	belongs_to :application

	validates :application_id, presence: true

	def get_events
		Event.where("end_user_id = ?", id)
	end
end