class Segment
  attr_accessor :max_length
  attr_reader :style

  def initialize(style)
    @style = style
  end
end
