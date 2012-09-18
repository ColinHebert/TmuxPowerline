# encoding: UTF-8
require 'style/separator'

class Style::Thick < Style::Separator
  def initialize
    super ' ⮀', '⮂ '
  end

  def flatten(current_formatting)
    @separator_formatting.fg_color ||= @formatting.bg_color
    @formatting.bg_color ||= @separator_formatting.fg_color
    super
  end

  def transition(transition_color)
    @separator_formatting.bg_color = transition_color
  end
end
