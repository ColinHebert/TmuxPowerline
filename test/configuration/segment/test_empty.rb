require 'helper'
require 'segment/empty'

class TestEmpty < Test::Unit::TestCase
  setup do
    @segment = Segment::Empty.new nil
  end

  should "always be empty" do
    assert @segment.content.empty?
  end

  should "always be displayed" do
    assert @segment.displayed?
  end
end
