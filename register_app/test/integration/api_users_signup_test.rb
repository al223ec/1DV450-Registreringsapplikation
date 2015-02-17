require 'test_helper'

class ApiUsersSignupTest < ActionDispatch::IntegrationTest
	#TODO: Kanske testa mer utförligt där varje enskilt fält inte är fel
	test "invalid signup information" do
		get signup_path
		assert_no_difference 'ApiUser.count' do
			post api_users_path, api_user: { 
				name:  "", 
				email: "user@invalid",
				password: "foo",
				password_confirmation: "bar" 
			}
		end
		assert_template 'api_users/new'
	end

	test "valid signup information" do
		get signup_path
		assert_difference 'ApiUser.count', 1 do
			post_via_redirect api_users_path, api_user: { 
				name:  "Example User", 
				email: "user@example.com",
				password: "password",
				password_confirmation: "password" 
			}
		end
		assert_template 'api_users/show'
		assert is_logged_in? #Testar att användaren blir inloggad så fort hen har registrerat sig 
	end
end
