require 'test_helper'

class ApiUsersControllerTest < ActionController::TestCase
	def setup
		@api_user = users(:mikael)
		@other_user = users(:archer)
	end

	test "should get new" do
		get :new
		assert_response :success
	end

	test "should redirect index when not logged in" do
    	get :index
    	assert_redirected_to root_url
  	end

	test "should redirect edit when not logged in" do
		get :edit, id: @api_user
		assert_not flash.empty?
		assert_redirected_to login_url
	end

	test "should redirect update when not logged in" do
		patch :update, id: @api_user, user: { name: @api_user.name, email: @api_user.email }
		assert_not flash.empty?
		assert_redirected_to login_url
	end

	test "should redirect edit when logged in as wrong user" do
		log_in_as(@other_user)
		get :edit, id: @api_user
		assert flash.empty?
		assert_redirected_to root_url
	end

	test "should redirect from index when logged in as wrong user and not admin" do
		log_in_as(@other_user)
		get :index, id: @api_user
		assert flash.empty?
		assert_redirected_to root_url
	end

	test "should redirect update when logged in as wrong user" do
		log_in_as(@other_user)
		patch :update, id: @api_user, user: { name: @api_user.name, email: @api_user.email }
		assert flash.empty?
		assert_redirected_to root_url
	end
	
	test "should redirect destroy when not logged in" do
		assert_no_difference 'ApiUser.count' do
			delete :destroy, id: @api_user
		end
		assert_redirected_to login_url
	end

	test "should redirect destroy when logged in as a non-admin" do
		log_in_as(@other_user)
		assert_no_difference 'ApiUser.count' do
			delete :destroy, id: @api_user
		end
		assert_redirected_to root_url
	end

	test "should not allow the admin attribute to be edited via the web" do
		log_in_as(@other_user)
		assert_not @other_user.admin?

	 	patch :update, id: @other_user, api_user: { 
	 		password: 'password',
	     	password_confirmation: 'password',
	        admin: 1
	    }
	 	assert_not @other_user.admin?
	end
end
