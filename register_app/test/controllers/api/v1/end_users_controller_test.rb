require 'api_test_helper'

module Api
	class V1::EndUsersControllerTest < ApiBaseControllerTest
		def setup
			setup_header_and_user
		end

		test "login should be successful" do
			post :login, end_user: { email: @end_user.email, password:"password" }
			assert_response :success
		end

		test "login should not be successful" do
			post :login, end_user: { email: @end_user.email, password:" " }
			assert_response :unauthorized
		end

		test "login should not be successful using user from other application" do
			other_user = users(:otherEndUser)
			post :login, end_user: { email: other_user.email, password:"password" }
			assert_response :unauthorized
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
			assert body["email"] == user_attributes[:email]
		end
	end
end
