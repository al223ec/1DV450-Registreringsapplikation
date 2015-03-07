require 'test_helper'

class ApiUsersProfileTest < ActionDispatch::IntegrationTest
	include ApplicationHelper

	def setup
    	@api_user = users(:mikael)
	end

	test "profile display" do
		log_in_as_api_user(@api_user)
		get api_user_path(@api_user)

		assert_template 'api_users/show'
		assert_select 'title', full_title(@api_user.name)
		assert_select 'h2', text: @api_user.name
		#response.body contains the full HTML source of the page (and not just the page’s body)
		assert_match @api_user.applications.count.to_s, response.body
		assert_select 'div.pagination'

		@api_user.applications.paginate(page: 1).each do |application|
			assert_match application.name, response.body
		end
  	end
end
