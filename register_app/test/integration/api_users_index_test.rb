require 'test_helper'

class ApiUsersIndexTest < ActionDispatch::IntegrationTest
	
	def setup
		@api_user = users(:mikael)
		@admin = users(:mikael)
		@non_admin = users(:archer)
	end

	test "index including pagination" do
		log_in_as_api_user(@api_user)
		get api_users_path
		assert_template 'api_users/index'
		assert_select 'div.pagination'

		ApiUser.paginate(page: 1).each do |api_user|
			assert_select 'a[href=?]', api_user_path(api_user), text: api_user.name
		end
  	end

  	test "index as admin including pagination and delete links" do
		log_in_as_api_user(@admin)
		get api_users_path

		assert_template 'api_users/index'
		assert_select 'div.pagination'
		first_page_of_api_users = ApiUser.paginate(page: 1)

		first_page_of_api_users.each do |api_user|
			assert_select 'a[href=?]', api_user_path(api_user), text: api_user.name
			unless api_user == @admin
				assert_select 'a[href=?]', api_user_path(api_user), method: :delete
			end
		end
		assert_difference 'ApiUser.count', -1 do
		  delete api_user_path(@non_admin)
		end
	end

	test "index as non-admin" do
		log_in_as_api_user(@non_admin)
		get api_users_path
		
		assert_select 'a', text: 'delete', count: 0
	end
end
