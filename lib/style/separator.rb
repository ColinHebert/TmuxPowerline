require 'style/style'

class Style::Separator < Style
  attr_accessor :separator_ltr
  attr_accessor :separator_rtl

  def initialize(separator, separator_rtl = separator)
    @separator_ltr = separator
    @separator_rtl = separator_rtl
  end

  def format(content)
    if @orientation == Configuration::ORIENTATIONS[:LTR]
      content + ' ' + separator_ltr
    elsif @orientation == Configuration::ORIENTATIONS[:RTL]
      separator_rtl + ' ' + content
    end
  end
end
