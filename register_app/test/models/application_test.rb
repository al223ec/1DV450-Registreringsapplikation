require 'test_helper'

class ApplicationTest < ActiveSupport::TestCase

	def setup
		@user = users(:mikael)
		@application = @user.applications.build(name: "applicationName")
	end

	test "should be valid" do
		assert @application.valid?
	end

	test "user id must be present" do
		@application.user_id = nil
		assert_not @application.valid?
	end

	test "key must be present " do
    	@application.key = "   "
    	assert_not @application.valid?
  	end

	test "key should be at most 141 characters" do
	    @application.key = "a" * 141
	    assert_not @application.valid?
  	end

  	test "key should be at least 30 characters"   do
	    @application.key = "a" * 30
	    assert_not @application.valid?
  	end

  	# TODO:Fixa detta test
  	test "key must be unique" do
		duplicate_application = @application.dup
		duplicate_application.key = @application.key
		@application.save
		assert_not duplicate_application.key == @application.key
  	end
end
