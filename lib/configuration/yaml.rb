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

    @configuration[section]['segments'].each do |segment_config|
      segment_style = generate_style(segment_config['style'])
      segment = create_segment(segment_config['type'], segment_style)
      segment_config.each do |key, value|
        next if key == 'type' || key == 'style'

        begin
          segment.send key+'=', value
        rescue NoMethodError => e
          #TODO: Log the exception
          puts e.message
        end
      end
      segments << segment
    end unless @configuration[section]['segments'].nil?

    segments
  end

  def generate_style(style_config)
    style = create_style(style_config['type'])
    style_config.each do |key, value|
      next if key == 'type'

      begin
        style.send key+'=', value
      rescue NoMethodError => e
        #TODO: Log the exception
        puts e.message
      end
    end

    style
  end
  private :generate_style

  def get_orientation(section)
    @configuration[section]['orientation'] || super(section)
  end
end
