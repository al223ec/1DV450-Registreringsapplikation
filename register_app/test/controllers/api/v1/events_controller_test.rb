require 'api_test_helper'

module Api
	class V1::EventsControllerTest < ApiBaseControllerTest
		def setup
			setup_header_and_user

			@event = events(:banana)
			@event.end_user = @end_user
			@position = positions(:one)
		end		
			
		test "should get index and be successful" do
			get :index
			assert_response :success
		end

		test "should get show and be successful" do
			get :show, id: @event.id
			assert_response :success
		end

		test "post new invalid event information" do
			assert_no_difference 'Event.count' do
				post :create, jwt: @jwt, event: { 
					content:  "",
					position_id: @position.id 
				}
			end
			assert_response :unprocessable_entity
		end

		test "post new valid event " do
			event_attr = { content: "Example content "}
			
			assert_difference 'Event.count', 1 do
				post :create, jwt: @jwt, event: { 
					content:  event_attr[:content],
					position_id: @position.id,
					end_user_id: @end_user.id,
					application_id: @application_id,
				}
			end

			assert_response :created
			body = JSON.parse(response.body)
			assert body["event"]["content"] == event_attr[:content]
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