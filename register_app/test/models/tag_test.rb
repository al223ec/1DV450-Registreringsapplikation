require 'test_helper'

class TagTest < ActiveSupport::TestCase
	def setup
	    @tag = Tag.new(name: "Tagname")
	end

  	test "should be valid" do
    	assert @tag.valid?
  	end

  	test "name must be present" do
  		@tag.name = nil
  		assert_not @tag.valid?
  	end

  	test "should not validate to long tag" do
  		@tag.name = 'a' * 41
    	assert_not @tag.valid?
  	end

  	test "should not validate to short tag" do
  		@tag.name = 'a'
    	assert_not @tag.valid?
  	end

    test "should not be able to ad tag with same name" do
      @tag.save
      tag = Tag.new(name: @tag.name)
      assert_not tag.valid?
    end

end
