require 'segment/segment'

class Segment::Plain < Segment
  attr_accessor :content

  def displayed?
    ! (@content.nil? || @content.empty? )
  end
end
