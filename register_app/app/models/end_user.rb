class EndUser < User
	has_many :events
	belongs_to :application

	validates :application_id, presence: true

	def get_events
		Event.where("end_user_id = ?", id)
	end

	#Endast för testning
	def get_jwt
		 JWT.encode({ end_user_id: id, expiered: 2.hours.from_now.to_i }, Rails.application.secrets.secret_key_base, "HS512")
	end
end
