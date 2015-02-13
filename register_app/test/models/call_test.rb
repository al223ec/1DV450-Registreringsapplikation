require 'test_helper'

class CallTest < ActiveSupport::TestCase
	def setup
		@application = applications(:orange)
		@call = @application.calls.build(ip: "172.120.12.1", caller: "crhome")
	end

	test "call should be valid" do
		assert @call.valid?
	end

	test "application id must be present" do
		@call.application_id = nil
		assert_not @call.valid?
	end

	test "call should not be vaild if it's updated" do
		@call.save
		@call.ip = "172.1.12.1"
		assert_not @call.valid?
	end
end
