require 'configuration/configuration'
require 'yaml'

class Yaml < Configuration
  def load_file(filename)
    @configuration = YAML::load_file filename
  end

  def load(stream)
    @configuration = YAML::load stream
  end

  def get_section(section)
    configuration_section = @configuration[section]
    raise UndefinedSectionError, "Undefined section '#{section}'" if configuration_section.nil?
  end
end
