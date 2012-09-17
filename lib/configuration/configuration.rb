class Configuration
  def get_section(section)
    raise NotImplementedError, 'Not yet implemented'
  end
end

class UndefinedSectionError < StandardError
end
