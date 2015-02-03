require 'test_helper'

class StaticPagesControllerTest < ActionController::TestCase
	#base_title bör flyttas ut
	def setup
    	@base_title = "Ruby on Rails Register Api TOERH"
	end

  	test "should get home" do
    	get :home
    	assert_response :success
		assert_select "title", "#{@base_title}"
  	end

	test "should get about" do
		get :about
		assert_response :success
		assert_select "title", "About | #{@base_title}"
	end
end
