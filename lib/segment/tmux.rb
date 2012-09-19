require 'segment/command'

class Segment::Tmux < Segment::Command
  def initialize(style)
    super
    @command = 'tmux display -p '
  end

  def content=(value)
    @command << "'#{value}'"
  end
end
