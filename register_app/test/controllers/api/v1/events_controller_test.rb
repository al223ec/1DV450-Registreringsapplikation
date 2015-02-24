require 'api_test_helper'

module Api
	class V1::EventsControllerTest < ActionController::TestCase
		def setup
			@event = events(:banana)
		end

	#require 'spec_helper'

	#describe UsersController do
	#   render_views # if you have RABL views

	#  before do
	#  @user_attributes = { email: "test@example.com", password: "mypass" }
	# end

	#   describe "POST to create" do

	#     it "should change the number of users" do
	#       lambda do
	#        post :create, user: @user_attributes
	#       end.should change(User, :count).by(1)
	#    end

	#    it "should be successful" do
	#      post :create, user: @user_attributes
	#      response.should be_success
	#    end
	#    

	#    it "should set @user" do
	#      post :create, user: @user_attributes
	#      assigns(:user).email.should == @user_attributes[:email]
	#    end

	#    it "should return created user in json" do # depend on what you return in action
	#      post :create, user: @user_attributes
	#      body = JSON.parse(response.body)
	#      body["email"].should == @user_attributes[:email]
	#     end
	# end
	end
end