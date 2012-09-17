require 'helper'

class TestYaml < Test::Unit::TestCase
  setup do
    @configuration=Yaml.new
    @configuration.load <<-CONFIG
      section-1:
        orientation: RTL
        segments: empty

      section-2:
        segments: empty

      status-right:
        segments: empty

      status:
        orientation: LTR
        segments: empty
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
end
