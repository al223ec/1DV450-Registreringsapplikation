require 'test_helper'

class EventTest < ActiveSupport::TestCase

	def setup
		@position = positions(:one)
		@end_user = users(:endUser)
		@application = applications(:app)
	    @event = Event.new(position: @position, end_user: @end_user, content: "Innehåll i test", application: @application)
	end

  	test "should be valid" do
    	assert @event.valid?
  	end
  	 
	test "user id should be present" do
		@event.end_user_id = nil
		assert_not @event.valid?
	end

	test "content should be present " do
		@event.content = "   "
		assert_not @event.valid?
	end

	test "content should be at most 140 characters" do
		@event.content = "a" * 141
		assert_not @event.valid?
	end

  	 test "order should be most recent first" do
    	assert_equal Event.first, events(:most_recent)
  	end
end
