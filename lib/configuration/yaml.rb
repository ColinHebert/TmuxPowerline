require 'configuration/configuration'
require 'yaml'

class Configuration::Yaml < Configuration
  def load_file(filename)
    @configuration = YAML::load_file filename
  end

  def load(stream)
    @configuration = YAML::load stream
  end

  def section_exists?(section)
    !@configuration[section].nil?
  end

  def get_section(section)
    raise UndefinedSectionError, "Undefined section '#{section}'" unless section_exists?(section)
    segments = []

    @configuration[section]['segments'].each do |segment|
      segments << segment
    end unless @configuration[section]['segments'].nil?

    segments
  end

  def get_orientation(section)
    @configuration[section]['orientation'] || super(section)
  end
end
