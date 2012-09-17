require 'helper'

class TestTmuxPowerline < Test::Unit::TestCase
  should "raise an exception if a configuration loader is given as nil" do
    assert_raise ArgumentError do
      TmuxPowerline.new nil
    end
  end
end
