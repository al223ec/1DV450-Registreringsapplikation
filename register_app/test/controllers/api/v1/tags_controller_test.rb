require 'api_test_helper'

module Api
	class V1::TagsControllerTest < ApiBaseControllerTest
		def setup
			setup_header_and_user
		end

		test "should get index and be successful" do
			get :index
			assert_response :success
		end
	end
end
