require 'helper'
require 'style/separator'

class TestSeparator < Test::Unit::TestCase
  setup do
    @style = Style::Separator.new 'a', 'b'
    @style.orientation=Configuration::ORIENTATIONS[:LTR]
  end

  should "display a formatted value with separators style" do
    assert_equal 'test a', @style.format('test')

    @style.orientation=Configuration::ORIENTATIONS[:RTL]
    assert_equal 'b test', @style.format('test')
  end

  should "use only one separator if only ltr has been provided" do
    @style = Style::Separator.new 'a'
    @style.orientation=Configuration::ORIENTATIONS[:LTR]
    assert_equal 'test a', @style.format('test')

    @style.orientation=Configuration::ORIENTATIONS[:RTL]
    assert_equal 'a test', @style.format('test')
  end
end
