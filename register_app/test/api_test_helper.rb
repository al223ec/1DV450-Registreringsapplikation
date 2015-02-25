ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'

class ActiveSupport::TestCase
  	# Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  	fixtures :all

  	def log_in_as_end_user
  		#end_user = users(:endUser)
  		#app = applications(:app)
 # 		user = {password: 'password', email: ""}
#
		#post api_end_users_login_url, { end_user: user }, :json, :subdomain => "api" 
		
  		#post api_end_users_login_url.json #, '{"foo":"bar", "bool":true}', "CONTENT_TYPE" => 'application/json'
	end
end