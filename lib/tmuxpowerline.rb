class TmuxPowerline
  def initialize(configuration_loader)
    if configuration_loader.nil?
      raise "The configuration loader can't be nil"
    end
    @configuration_loader = configuration_loader
  end
end
