class Segment
  attr_accessor :max_length
  attr_accessor :orientation
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
end
