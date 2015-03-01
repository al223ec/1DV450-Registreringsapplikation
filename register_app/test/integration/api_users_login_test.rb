require 'test_helper'

class ApiUsersLoginTest < ActionDispatch::IntegrationTest
	def setup
		@api_user = users(:mikael)
	end


	test "login with invalid information" do
		get login_path
		assert_template 'sessions/new'
		post login_path, session: { email: "", password: "" }
		assert_template 'sessions/new'
		assert_not flash.empty?
		get root_path
		assert flash.empty?
	end

	# Visit the login path.
	# Post valid information to the sessions path.
	# Verify that the login link disappears.
	# Verify that a logout link appears
	# Verify that a profile link appears.
	test "login with valid information" do
		get login_path
		post login_path, session: { email: @api_user.email, password: 'password' }
		assert_redirected_to @api_user
		follow_redirect!
		assert_template 'api_users/show'
		assert_select "a[href=?]", login_path, count: 0
		assert_select "a[href=?]", logout_path
		assert_select "a[href=?]", api_user_path(@api_user)
	end

	#Detta test börjar bli för komplext bör bryta ut detta till fler test
	test "login with valid information followed by logout" do
		get login_path
		post login_path, session: { email: @api_user.email, password: 'password' }
		assert is_logged_in?
		assert_redirected_to @api_user
		follow_redirect!
		assert_template 'api_users/show'
		assert_select "a[href=?]", login_path, count: 0
		assert_select "a[href=?]", logout_path
		assert_select "a[href=?]", api_user_path(@api_user)
		delete logout_path
		assert_not is_logged_in?
		assert_redirected_to root_url
		# Simulate a user clicking logout in a second window.
    	delete logout_path
		follow_redirect!
		assert_select "a[href=?]", login_path
		assert_select "a[href=?]", logout_path,      count: 0
		assert_select "a[href=?]", api_user_path(@api_user), count: 0
  	end

	test "login with remembering" do
		log_in_as_api_user(@api_user, remember_me: '1')
		assert_not_nil cookies['remember_token']
	end

	test "login without remembering" do
		log_in_as_api_user(@api_user, remember_me: '0')
		assert_nil cookies['remember_token']
	end
end
