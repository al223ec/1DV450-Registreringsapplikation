class Application < ActiveRecord::Base
	#before_create:generateKey
	has_many :calls, dependent: :destroy
	belongs_to :api_user
	has_many :end_users

	default_scope -> { order(created_at: :desc) }
	
	validates :api_user_id, presence: true
	validates :key, presence: true, length: { maximum: 140, minimum:31 }, uniqueness: true

	before_validation(on: :create) do 
		generateKey
	end

	def Application.new_key
		SecureRandom.base64(32).tr('+/=', 'Qrt')
	end

	private 
		def generateKey
			if self.key.nil?
				begin
	    			self.key = SecureRandom.base64(32).tr('+/=', 'Qrt')
	  			end while self.class.exists?(key: self.key)
	  		end
		end
end
