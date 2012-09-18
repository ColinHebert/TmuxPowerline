require 'helper'

class TestYaml < Test::Unit::TestCase
  setup do
    @configuration=Configuration::Yaml.new
    @configuration.load_config <<-CONFIG
      section-1:
        orientation: RTL
        segments:
          - type: empty
            style: {type: thick, bg_color: green, fg_color: black}
          - type: plain
            max_length: 10
            fake_property: lol
            style: {type: thin, fg_color: blue}
          - type: empty
            style: {type: thin}

      section-2:
        segments:
          - type: empty
            style: {type: thin}

      status-right:
        segments:
          - type: empty
            style: {type: thin}

      status:
        orientation: LTR
    CONFIG
  end

  should "return true if the section exists, false otherwise" do
    assert @configuration.section_exists? 'section-1'
    assert !@configuration.section_exists?('fake_section')
  end

  should "raise an exception if the chosen section doesn't exist" do
    assert_raise UndefinedSectionError do
      @configuration.get_section 'fake_section'
    end
  end

  should "obtain a section orientation if it's defined" do
    assert_equal Configuration::ORIENTATIONS[:RTL], @configuration.get_orientation('section-1')
    assert_equal Configuration::ORIENTATIONS[:LTR], @configuration.get_orientation('status')
  end

  should "define the default section orientation if none has been defined" do
    assert_equal Configuration::ORIENTATIONS[:LTR], @configuration.get_orientation('section-2')
    assert_equal Configuration::ORIENTATIONS[:RTL], @configuration.get_orientation('status-right')
  end

  should "obtain the correct number of segments, even if the property isn't defined" do
    assert_equal 3, @configuration.get_section('section-1').size
    assert_equal 1, @configuration.get_section('status-right').size
    assert_equal 1, @configuration.get_section('section-2').size
    assert_equal 0, @configuration.get_section('status').size
  end

  should "generate segments based on the type defined in the configuration" do
    assert @configuration.get_section('section-1')[0].is_a?(Segment::Empty)
    assert @configuration.get_section('section-1')[1].is_a?(Segment::Plain)
  end

  should "set automatically the properties for each segment" do
    assert_equal 10, @configuration.get_section('section-1')[1].max_length
  end

  should "set the segment style" do
    assert @configuration.get_section('section-1')[0].style.is_a?(Style::Thick)
    assert @configuration.get_section('section-1')[1].style.is_a?(Style::Thin)
  end

  should "set the segment style properties automatically" do
    assert_equal 'green', @configuration.get_section('section-1')[0].style.bg_color
    assert_equal 'blue', @configuration.get_section('section-1')[1].style.fg_color
  end
end
