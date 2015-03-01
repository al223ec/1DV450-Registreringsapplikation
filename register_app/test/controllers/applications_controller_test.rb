require 'test_helper'

class ApplicationsControllerTest < ActionController::TestCase
	
	def setup
		@application = applications(:orange)
	end

	# Tests to enforce logged-in status. We simply issue the correct request to each action and confirm that the 
	# application count is unchanged and the result is redirected to the login URL

	test "should redirect create when not logged in" do
		assert_no_difference 'Application.count' do
			post :create, application: { name: "Lorem ipsum" }
		end
		assert_redirected_to login_url
	end

	test "should redirect destroy when not logged in" do
		assert_no_difference 'Application.count' do
			delete :destroy, id: @application
		end
		assert_redirected_to login_url
	end

	test "should redirect destroy for wrong application" do
		log_in_as_api_user(users(:archer))
		application = applications(:cat_video)

		assert_no_difference 'Application.count' do
	  		delete :destroy, id: application
		end
		assert_redirected_to root_url
	end
end
