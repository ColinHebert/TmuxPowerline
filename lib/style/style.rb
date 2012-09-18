class Style
  attr_accessor :fg_color
  attr_accessor :bg_color
  attr_accessor :orientation

  def format(content)
    raise NotImplementedError, 'Not yet implemented'
  end
end
