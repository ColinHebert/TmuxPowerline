require 'configuration/yaml'
require 'style/style'

class TmuxPowerline
  def initialize(configuration_loader=Configuration::Yaml.new)
    if configuration_loader.nil?
      raise ArgumentError, "The configuration loader can't be nil"
    end
    @configuration_loader = configuration_loader
  end

  def load_config(config)
    @configuration_loader.load_config config
  end

  def get(section)
    segments = @configuration_loader.get_section section
    returned_value = ''
    current_formatting = Style::Formatting.default

    segments.each do |segment|
      next unless segment.displayed?
      segment.style.flatten current_formatting
      returned_value << segment
    end

    returned_value
  end
end
