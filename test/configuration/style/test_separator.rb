require 'helper'
require 'style/separator'

class TestSeparator < Test::Unit::TestCase
  setup do
    @style = Style::Separator.new ' a', 'b '
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
    assert_equal 'testa', @style.format('test')

    @style.orientation=Configuration::ORIENTATIONS[:RTL]
    assert_equal 'atest', @style.format('test')
  end

  should "format the content" do
    @style.fg_color='blue'
    @style.bg_color='green'
    assert_equal '#[fg=blue,bg=green]test a', @style.format('test')

    @style.orientation=Configuration::ORIENTATIONS[:RTL]
    assert_equal 'b #[fg=blue,bg=green]test', @style.format('test')
  end

  should "format the separator" do
    @style.separator_fg_color='blue'
    @style.separator_bg_color='green'
    assert_equal 'test#[fg=blue,bg=green] a', @style.format('test')

    @style.orientation=Configuration::ORIENTATIONS[:RTL]
    assert_equal '#[fg=blue,bg=green]b test', @style.format('test')
  end

  should "simplify the format in left to right" do
    @style.fg_color='blue'
    @style.bg_color='black'
    @style.separator_fg_color='blue'
    @style.separator_bg_color='green'
    @style.flatten Style::Formatting.default

    assert_equal '#[fg=blue,bg=black]test#[bg=green] a', @style.format('test')
  end

  should "simplify the format in right to left" do
    @style.orientation=Configuration::ORIENTATIONS[:RTL]
    @style.fg_color='blue'
    @style.bg_color='black'
    @style.separator_fg_color='blue'
    @style.separator_bg_color='green'
    @style.flatten Style::Formatting.default

    assert_equal '#[fg=blue,bg=green]b #[bg=black]test', @style.format('test')
  end
end
