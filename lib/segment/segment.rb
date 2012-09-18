class Segment
  attr_accessor :max_length
  attr_reader :style

  def initialize(style)
    @style = style
    @max_length = -1
  end

  def content
    raise NotImplementedError, 'Not yet implemented'
  end

  def displayed?
    false
  end

  def to_str
    @style.format content[0..@max_length]
  end

  def orientation=(value)
    @style.orientation = value
  end
end
