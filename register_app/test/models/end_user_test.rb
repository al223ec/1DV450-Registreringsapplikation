require 'test_helper'

class EndUserTest < ActiveSupport::TestCase
	def setup
		@application = applications(:orange)
	    @end_user = EndUser.new(name: "Example User", email: "user@example.com",
                     password: "foobar", password_confirmation: "foobar", application: @application, 
                     application_id: @application.id)
	end

  	test "should be valid" do
    	assert @end_user.valid?
  	end
end