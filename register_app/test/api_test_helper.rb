ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'

class ActiveSupport::TestCase
  	# Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  	fixtures :all

  	def log_in_as_end_user
  		end_user = users(:endUser)
  		app = applications(:app)
  		post 'api.lvh.me:3000/end_users/login'
  		
  		#post api_end_users_login_url.json #, '{"foo":"bar", "bool":true}', "CONTENT_TYPE" => 'application/json'
	end
end