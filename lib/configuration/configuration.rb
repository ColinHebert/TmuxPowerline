require 'segment/segment'
require 'style/style'

class Configuration
  # Available segment orientations, Left To Right and Right To Left
  ORIENTATIONS = {:LTR => "LTR", :RTL => "RTL"}
  def ORIENTATIONS.[](index)
    index = index.upcase.to_sym if index.is_a?(String)
    super(index)
  end

  # Default orientation for each supported section
  DEFAULT_ORIENTATIONS = {:'status-left' => ORIENTATIONS[:LTR],
                          :'status-right' => ORIENTATIONS[:RTL],
                          :'status' => ORIENTATIONS[:LTR],
                          :'status-current' => ORIENTATIONS[:LTR]}

  def load_config(config)
    raise NotImplementedError, 'Not yet implemented'
  end

  def section_exists?(section)
    raise NotImplementedError, 'Not yet implemented'
  end

  def get_section(section)
    raise NotImplementedError, 'Not yet implemented'
  end

  def get_orientation(section)
    DEFAULT_ORIENTATIONS[section.to_sym] || ORIENTATIONS[:LTR]
  end

  def create_segment(type, style)
    require 'segment/' + type
    Segment::const_get(type.capitalize).new style
  end
  private :create_segment

  def create_style(style)
    require 'style/' + style
    Style::const_get(style.capitalize).new
  end
  private :create_style
end

class UndefinedSectionError < StandardError
end
