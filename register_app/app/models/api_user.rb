class ApiUser < User
	has_many :applications, dependent: :destroy

	#id is properly escaped before being included in the underlying SQL query, thereby avoiding a serious security hole called SQL injection
	def get_applications
		Application.where("api_user_id = ?", id)
	end
end