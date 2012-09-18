class Style
  attr_reader :formatting
  attr_accessor :orientation

  def initialize
    @formatting = Style::Formatting.new
  end

  def flatten(current_formatting)
    @formatting.flatten current_formatting
  end

  def format(content)
    raise NotImplementedError, 'Not yet implemented'
  end

  def fg_color=(value)
    @formatting.fg_color=value
  end

  def bg_color=(value)
    @formatting.bg_color=value
  end

  class Formatting
    attr_accessor :fg_color
    attr_accessor :bg_color

    def initialize(fg_color = nil, bg_color = nil)
      @fg_color = fg_color
      @bg_color = bg_color
    end

    def flatten(current_formatting)
      @fg_color = nil if @fg_color == current_formatting.fg_color
      @bg_color = nil if @bg_color == current_formatting.bg_color

      current_formatting.fg_color = @fg_color unless @fg_color.nil?
      current_formatting.bg_color = @bg_color unless @bg_color.nil?
    end

    def self.default
      formatting = Style::Formatting.new
      formatting.bg_color='default'
      formatting.fg_color='default'
      formatting
    end

    def to_str
      formatting_changed = false
      formatting = "#["

      if @fg_color && !@fg_color.empty?
        formatting << "fg="+@fg_color
        formatting_changed = true
      end

      if @bg_color && !@bg_color.empty?
        formatting << "," if formatting_changed
        formatting << "bg="+@bg_color
        formatting_changed = true
      end

      formatting << "]"

      formatting_changed ? formatting : ""
    end
  end

end
