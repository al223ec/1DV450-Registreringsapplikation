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

		test "post new invalid event information" do
			@request.env['HTTP_JWT'] = @end_user.get_jwt
			assert_no_difference 'Event.count' do
				post :create, event: {
					content:  "",
					position_id: @position.id
				}
			end
			assert_response :unprocessable_entity
		end

		test "post new valid event " do
			@request.env['HTTP_JWT'] = @end_user.get_jwt
			event_attr = { content: "Example content "}

			assert_difference 'Event.count', 1 do
				post :create, event: {
					content:  event_attr[:content],
					position_id: @position.id,
					end_user_id: @end_user.id,
					application_id: @application_id,
				}
			end

			assert_response :created
			body = JSON.parse(response.body)
			assert body["content"] == event_attr[:content]
		end

		test "post new valid event but invalid JWT" do
			@request.env['HTTP_JWT'] = "invalid jwt"

			event_attr = { content: "Example content "}
			assert_no_difference 'Event.count' do
				post :create, event: {
					content:  event_attr[:content],
					position_id: @position.id,
					end_user_id: @end_user.id,
					application_id: @application_id,
				}
			end

			assert_response :unauthorized
		end

		test "post new valid event but no JWT" do

			event_attr = { content: "Example content "}
			assert_no_difference 'Event.count' do
				post :create, event: {
					content:  event_attr[:content],
					position_id: @position.id,
					end_user_id: @end_user.id,
					application_id: @application_id,
				}
			end

			assert_response :unauthorized
		end

		test "post new valid event but user belongs to another application" do
			other_user = users(:otherEndUser)
			other_user.application = applications(:orange)

			@request.env['HTTP_JWT'] = other_user.get_jwt

			event_attr = { content: "Example content "}
			assert_no_difference 'Event.count' do
				post :create, event: {
					content:  event_attr[:content],
					position_id: @position.id,
					end_user_id: other_user.id,
					application_id: other_user.application_id,
				}
			end

			assert_response :unauthorized
		end

		test "successful edit of event" do
			@request.env['HTTP_JWT'] = @end_user.get_jwt
			new_content = "new content"

			event = events(:banana)
			event.end_user = @end_user
			event.application = @application
			event.save

			patch :update, id: event.id, event: {
				content: new_content,
#				tags:[{ name: "new tag" }],
				position_id: @position.id
			}
			assert_response :success

			body = JSON.parse(response.body)

			assert body["content"] == new_content
			# Har pajat denna, kan inte posta taggar från test just nu debugger
			# assert body["tags"][0]["tag"]["name"] == "new tag"
		end

		test "unsuccessful edit of event" do
			@request.env['HTTP_JWT'] = @end_user.get_jwt
			new_content = ""

			event = events(:banana)
			event.end_user = @end_user
			event.application = @application

			patch :update, id: event.id, event: {
				content: new_content,
#				tags:{ "0" => "new tag" },
				position_id: @position.id
			}
			assert_response :unprocessable_entity
		end
	end
end
