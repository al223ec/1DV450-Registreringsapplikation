class EndUser < User
	has_many :events
	belongs_to :application

	validates :application_id, presence: true

	def get_events
		Event.where("end_user_id = ?", id)
	end

	#Endast för testning
	def get_jwt
		 JWT.encode({ end_user_id: id }, application.name)
	end
end