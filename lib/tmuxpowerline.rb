require 'configuration/yaml'

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

    segments.each do |segment|
      next unless segment.displayed?
      segment.style.simplify
      returned_value << segment
    end

    returned_value
  end
end
