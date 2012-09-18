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
  end
end
