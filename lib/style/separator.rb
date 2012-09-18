require 'style/style'

class Style::Separator < Style
  attr_accessor :separator_ltr
  attr_accessor :separator_rtl
  attr_accessor :separator_fg_color
  attr_accessor :separator_bg_color

  def initialize(separator, separator_rtl = separator)
    @separator_ltr = separator
    @separator_rtl = separator_rtl
  end

  def simplify
    if @orientation == Configuration::ORIENTATIONS[:LTR]
      @separator_fg_color = nil if @fg_color == @separator_fg_color
      @separator_bg_color = nil if @bg_color == @separator_bg_color
    elsif @orientation == Configuration::ORIENTATIONS[:RTL]
      @fg_color = nil if @fg_color == @separator_fg_color
      @bg_color = nil if @bg_color == @separator_bg_color
    end
  end

  def format(content)
    if @orientation == Configuration::ORIENTATIONS[:LTR]
      Style::formatting(@fg_color, @bg_color) + content +
          ' ' + Style::formatting(@separator_fg_color, @separator_bg_color) + separator_ltr

    elsif @orientation == Configuration::ORIENTATIONS[:RTL]
      Style::formatting(@separator_fg_color, @separator_bg_color) + separator_rtl + ' ' +
          Style::formatting(@fg_color, @bg_color) + content
    end
  end
end
