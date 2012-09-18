require 'helper'
require 'segment/plain'

class TestPlain < Test::Unit::TestCase
  setup do
    @segment = Segment::Plain.new nil
    @segment.content='content'
  end

  should "contain what has been manually set" do
    assert_equal 'content', @segment.content
    @segment.content='new-content'
    assert_equal 'new-content', @segment.content
  end
end
