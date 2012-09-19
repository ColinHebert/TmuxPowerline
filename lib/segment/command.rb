require 'segment/segment'

class Segment::Command < Segment
  attr_accessor :command

  def initialize(style)
    super
  end

  def content
    if @result.nil?
      puts @command
      @result = `#@command`.chomp
    end
    @result
  end

  def displayed?
    ! (content.nil? || content.empty? )
  end
end
