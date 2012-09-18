# encoding: UTF-8
require 'style/separator'

class Style::Thick < Style::Separator
  def initialize
    super ' ⮀', '⮂ '
  end
end
