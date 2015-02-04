require 'test_helper'

class UsersSignupTest < ActionDispatch::IntegrationTest
	#TODO: Kanske testa mer utförligt där varje enskilt fält inte är fel
	test "invalid signup information" do
		get signup_path
		assert_no_difference 'User.count' do
			post users_path, user: { 
				name:  "", 
				email: "user@invalid",
				password: "foo",
				password_confirmation: "bar" 
			}
		end
		assert_template 'users/new'
	end

	test "valid signup information" do
		get signup_path
		assert_difference 'User.count', 1 do
			post_via_redirect users_path, user: { 
				name:  "Example User", 
				email: "user@example.com",
				password: "password",
				password_confirmation: "password" 
			}
		end
		assert_template 'users/show'
		assert is_logged_in? #Testar att användaren blir inloggad så fort hen har registrerat sig 
	end
end
