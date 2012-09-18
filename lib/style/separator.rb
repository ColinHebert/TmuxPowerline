require 'style/style'

class Style::Separator < Style
  attr_accessor :separator_ltr
  attr_accessor :separator_rtl
  attr_reader :separator_formatting

  def initialize(separator = '', separator_rtl = separator)
    super()
    @separator_ltr = separator
    @separator_rtl = separator_rtl
    @separator_formatting = Style::Formatting.new
  end

  def flatten(current_formatting)
    if @orientation == Configuration::ORIENTATIONS[:LTR]
      @formatting.flatten current_formatting
      @separator_formatting.flatten current_formatting
    elsif @orientation == Configuration::ORIENTATIONS[:RTL]
      @separator_formatting.flatten current_formatting
      @formatting.flatten current_formatting
    end
  end

  def format(content)
    if @orientation == Configuration::ORIENTATIONS[:LTR]
      '' + @formatting + content +
          @separator_formatting + separator_ltr

    elsif @orientation == Configuration::ORIENTATIONS[:RTL]
      '' + @separator_formatting + separator_rtl +
          @formatting + content
    end
  end

  def separator=(value)
    @separator_ltr = @separator_rtl = value
  end

  def separator_fg_color=(value)
    @separator_formatting.fg_color=value
  end

  def separator_bg_color=(value)
    @separator_formatting.bg_color=value
  end
end
