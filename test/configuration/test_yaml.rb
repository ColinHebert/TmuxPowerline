require 'helper'

class TestYaml < Test::Unit::TestCase
  setup do
    @configuration=Yaml.new
    @configuration.load <<-CONFIG
      section-1:
        orientation: RTL
        segments:
          - segment1: empty
          - segment2: empty
          - segment3: empty

      section-2:
        segments:
          - segment1: empty

      status-right:
        segments:
          - segment1: empty

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
end
