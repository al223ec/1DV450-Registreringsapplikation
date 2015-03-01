require 'api_test_helper'

class ApiBaseControllerTest < ActionController::TestCase
	def setup_header_and_user
		@application = applications(:app)
		@request.env['HTTP_ACCEPT'] = "application/json"
		@request.env['HTTP_AUTHORIZATION'] = "Token token=#{@application.key}"

		@end_user = users(:endUser)
		@end_user.application = @application
		@end_user.save
	end
end
