class Application < ActiveRecord::Base
	#before_create:generateKey
	belongs_to :user
	validates :user_id, presence: true
	validates :key, presence: true, length: { maximum: 140, minimum:31 }, uniqueness: true

	#detta verkar inte fungera, 
	before_validation(on: :create) do 
		generateKey
	end

	private 
		def initializeKey
		end

		def generateKey
			if self.key.nil?
				begin
	    			self.key = SecureRandom.base64(32).tr('+/=', 'Qrt')
	  			end while self.class.exists?(key: self.key)
	  		end
		end
end
