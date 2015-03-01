require 'test_helper'

class SessionsHelperTest < ActionView::TestCase
	def setup
		@api_user = users(:mikael)
		remember(@api_user)
	end

	test "current_user returns right api_user when session is nil" do
		assert_equal @api_user, current_user
		assert is_logged_in?
	end

	test "current_user returns nil when remember digest is wrong" do
		@api_user.update_attribute(:remember_digest, ApiUser.digest(ApiUser.new_token))
		assert_nil current_user
	end
end
