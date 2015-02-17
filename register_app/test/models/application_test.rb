require 'test_helper'

class ApplicationTest < ActiveSupport::TestCase

	def setup
		@api_user = users(:mikael)
		@application = @api_user.applications.build(name: "applicationName")
	end

	test "should be valid" do
		assert @application.valid?
	end

	test "user id must be present" do
		@application.api_user_id = nil
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

  	test "associated calls should be destroyed" do
		@application.save
		@application.calls.create!(ip: "170.20.145.2")
		
		assert_difference 'Call.count', -1 do
			@application.destroy
		end
  	end
end
