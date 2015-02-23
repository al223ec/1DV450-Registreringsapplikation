require 'test_helper'

class ApiUsersEditTest < ActionDispatch::IntegrationTest
	def setup
		@api_user = users(:mikael)
	end

	test "unsuccessful edit" do
		log_in_as_api_user(@api_user)

		get edit_api_user_path(@api_user)
		assert_template 'api_users/edit'
		patch api_user_path(@api_user), api_user: { 
			name: "",
			email: "foo@invalid",
			password: "foo",
			password_confirmation: "bar" 
		}
		assert_template 'api_users/edit'
	end

	test "successful edit" do
		log_in_as_api_user(@api_user)

		get edit_api_user_path(@api_user)
		assert_template 'api_users/edit'
		name  = "Foo Bar"
		email = "foo@bar.com"
		
		patch api_user_path(@api_user), api_user: { 
			name:  name,
			email: email,
			password: "",
			password_confirmation: "" 
		}
		assert_not flash.empty?
		assert_redirected_to @api_user
		@api_user.reload

		assert_equal @api_user.name,  name
		assert_equal @api_user.email, email
	end

	test "successful edit with friendly forwarding" do
		get edit_api_user_path(@api_user)
		log_in_as_api_user(@api_user)

		assert_redirected_to edit_api_user_path(@api_user)
		name  = "Foo Bar"
		email = "foo@bar.com"

		patch api_user_path(@api_user), api_user: { 
			name:  name,
			email: email,
		    password: "foobar",
		    password_confirmation: "foobar" 
		}
		assert_not flash.empty?
		assert_redirected_to @api_user
		@api_user.reload
		assert_equal @api_user.name,  name
		assert_equal @api_user.email, email
  	end
end
