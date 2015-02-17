require 'test_helper'

class EventTest < ActiveSupport::TestCase

	def setup
		@position = positions(:one)
	    @event = Event.new(position: @position)
	end

  	test "should be valid" do
    	assert @event.valid?
  	end
end
