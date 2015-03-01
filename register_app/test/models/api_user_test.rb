require 'test_helper'

class ApiUserTest < ActiveSupport::TestCase
	def setup
	    @api_user = ApiUser.new(name: "Example User", email: "user@example.com",
                     password: "foobar", password_confirmation: "foobar")
	end
	
	test "associated applications should be destroyed" do
		@api_user.save
		@api_user.applications.create!(name: "Lorem ipsum")
		
		assert_difference 'Application.count', -1 do
			@api_user.destroy
		end
  	end
end