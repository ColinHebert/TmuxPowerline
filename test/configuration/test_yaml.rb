require 'helper'

class TestYaml < Test::Unit::TestCase
  setup do
    @configuration=Configuration::Yaml.new
    @configuration.load_config <<-CONFIG
      existing-section: {}

      section-with-orientation:
        orientation: RTL
      status:
        orientation: LTR

      section-without-orientation: {}
      status-right: {}

      section-with-segments:
        segments:
          - type: empty
            style: {type: thick}
          - type: empty
            style: {type: thick}
          - type: empty
            style: {type: thick}
      section-without-segment: {}

      segment-types:
        segments:
          - type: empty
            style: {type: thick}
          - type: plain
            style: {type: thick}

      segment-properties:
        segments:
          - type: empty
            style: {type: thick}
            max_length: 10

      segment-styles:
        segments:
          - type: empty
            style: {type: thick}
          - type: empty
            style: {type: thin}

      style-properties:
        segments:
          - type: empty
            style: {type: thick, bg_color: green, fg_color: blue}

      segment-with-default-orientation:
        orientation: LTR
        segments:
          - type: empty
            style: {type: thin}

      segment-with-custom-orientation:
        orientation: RTL
        segments:
          - type: empty
            style: {type: thin}
            orientation: LTR
    CONFIG
  end

  should "return true if the section exists, false otherwise" do
    assert @configuration.section_exists? 'existing-section'
    assert !@configuration.section_exists?('fake-section')
  end

  should "raise an exception if the chosen section doesn't exist" do
    assert_raise UndefinedSectionError do
      @configuration.get_section 'fake-section'
    end
  end

  should "obtain a section orientation if it's defined" do
    assert_equal Configuration::ORIENTATIONS[:RTL], @configuration.get_orientation('section-with-orientation')
    assert_equal Configuration::ORIENTATIONS[:LTR], @configuration.get_orientation('status')
  end

  should "define the default section orientation if none has been defined" do
    assert_equal Configuration::ORIENTATIONS[:LTR], @configuration.get_orientation('section-without-orientation')
    assert_equal Configuration::ORIENTATIONS[:RTL], @configuration.get_orientation('status-right')
  end

  should "obtain the correct number of segments, even if the property isn't defined" do
    assert_equal 3, @configuration.get_section('section-with-segments').size
    assert_equal 0, @configuration.get_section('section-without-segment').size
  end

  should "generate segments based on the type defined in the configuration" do
    assert @configuration.get_section('segment-types')[0].is_a?(Segment::Empty)
    assert @configuration.get_section('segment-types')[1].is_a?(Segment::Plain)
  end

  should "set automatically the properties for each segment" do
    assert_equal 10, @configuration.get_section('segment-properties')[0].max_length
  end

  should "set the segment style" do
    assert @configuration.get_section('segment-styles')[0].style.is_a?(Style::Thick)
    assert @configuration.get_section('segment-styles')[1].style.is_a?(Style::Thin)
  end

  should "set the segment style properties automatically" do
    assert_equal 'green', @configuration.get_section('style-properties')[0].style.formatting.bg_color
    assert_equal 'blue', @configuration.get_section('style-properties')[0].style.formatting.fg_color
  end

  should "define the orientation on each segments" do
    assert_equal Configuration::ORIENTATIONS[:LTR],
                 @configuration.get_section('segment-with-default-orientation')[0].style.orientation
    assert_equal Configuration::ORIENTATIONS[:LTR],
                 @configuration.get_section('segment-with-custom-orientation')[0].style.orientation
  end
end
