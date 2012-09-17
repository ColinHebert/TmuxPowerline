require 'helper'

class TestYaml < Test::Unit::TestCase
  setup do
    @configuration=Yaml.new
    @configuration.load <<-CONFIG
      section-1:
        orientation: RTL
      section-2:
        orientation: RTL
      CONFIG
  end

  should "raise an exception if the chosen section doesn't exist" do
    assert_raise UndefinedSectionError do
      @configuration.get_section 'fake_section'
    end
  end
end
