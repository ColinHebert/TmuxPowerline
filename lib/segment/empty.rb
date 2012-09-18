require 'segment/segment'

class Segment::Empty < Segment
  def content
    ''
  end

  def displayed?
    true
  end
end
