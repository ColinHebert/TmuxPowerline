class Style
  attr_accessor :fg_color
  attr_accessor :bg_color
  attr_accessor :orientation

  def simplify
  end

  def format(content)
    raise NotImplementedError, 'Not yet implemented'
  end

  def self.formatting(fg_color = nil, bg_color = nil)
    formatting_changed = false
    formatting = "#["

    if fg_color && !fg_color.empty?
      formatting << "fg="+fg_color
      formatting_changed = true
    end

    if bg_color && !bg_color.empty?
      formatting << "," if formatting_changed
      formatting << "bg="+bg_color
      formatting_changed = true
    end

    formatting << "]"

    formatting_changed ? formatting : ""
  end
end
