require 'api_test_helper'

module Api
	class V1::EndUsersControllerTest < ActionController::TestCase
		def setup
			@end_user = users(:endUser)
			@application = applications(:app)
			@end_user.application = @application
			@end_user.save
			@request.env['HTTP_ACCEPT'] = "application/json"
			@request.env['HTTP_AUTHORIZATION'] = "Token token=#{@application.key}"
		end		

		test "login should be successful" do
			post :login, end_user: { email: @end_user.email, password:"password" }
			assert_response :success
		end

		test "login should not be successful" do
			post :login, end_user: { email: @end_user.email, password:" " }
			assert_response :bad_request
		end

		# Test for signup 
		test "invalid signup information" do
			assert_no_difference 'ApiUser.count' do
				post :create, end_user: { 
					name:  "", 
					email: "user@invalid",
					password: "foo",
					password_confirmation: "bar" 
				}
			end
			assert_response :unprocessable_entity
		end

		test "valid signup information" do
			user_attributes = { name: "Example user", email: "test@example.com", password: "password" }
			
			assert_difference 'EndUser.count', 1 do
				post :create, end_user: { 
					name:  user_attributes[:name], 
					email: user_attributes[:email],
					password: user_attributes[:password],
					password_confirmation: user_attributes[:password],
					application_id: @application.id
				}
			end

			assert_response :created
			body = JSON.parse(response.body)
			assert body["end_user"]["email"] == user_attributes[:email]
		end
	end
end