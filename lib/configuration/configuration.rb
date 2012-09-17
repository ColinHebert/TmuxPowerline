class Configuration
  def section_exists?(section)
    raise NotImplementedError, 'Not yet implemented'
  end

  def get_section(section)
    raise NotImplementedError, 'Not yet implemented'
  end
end

class UndefinedSectionError < StandardError
end
