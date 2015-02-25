require 'api_test_helper'

module Api
	class V1::TagsControllerTest < ActionController::TestCase
		def setup
			@application = applications(:app)
			@request.env['HTTP_ACCEPT'] = "application/json"
			@request.env['HTTP_AUTHORIZATION'] = "Token token=#{@application.key}"
		end

		test "should get index and be successful" do
			get :index
			assert_response :success
		end
		
	end
end