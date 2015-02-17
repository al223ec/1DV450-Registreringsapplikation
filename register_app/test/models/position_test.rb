require 'test_helper'

class PositionTest < ActiveSupport::TestCase
	def setup
	    @position = Position.new(lat: 59.422728, lng: 17.973633)
	end

  	test "should be valid" do
    	assert @position.valid?
  	end

  	test "should not validate strings in lat" do
  		@position.lat = "NaN"
  		assert_not @position.valid?
  	end

  	test "should not validate strings in lng" do
  		@position.lng = "NaN"
  		assert_not @position.valid?
  	end

  	test "should not validate latitude values lower than -90" do
  		@position.lat = -91
  		assert_not @position.valid?
  	end

  	test "should not validate latitude values higher than 90" do
  		@position.lat = 91
  		assert_not @position.valid?
  	end

  	test "should not validate Longitude  values lower than -180" do
  		@position.lng = -181
  		assert_not @position.valid?
  	end

  	test "should not validate Longitude  values higher than 180" do
  		@position.lng = 181
  		assert_not @position.valid?
  	end

    test "should not be able to delete position if it's associated to another obj" do
      @position.save
      event = Event.new(
        position: @position, 
        position_id: @position.id
      )
      event.save

      assert_no_difference 'Position.count' do
        @position.destroy
      end
    end
end
