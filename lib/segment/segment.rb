class Segment
  attr_accessor :max_length
  attr_reader :style

  def initialize(style)
    @style = style
  end

  def content
    raise NotImplementedError, 'Not yet implemented'
  end

  def displayed?
    false
  end

  def orientation
    @style.orientation
  end

  def orientation=(value)
    @style.orientation = value
  end
end
