class Journey
attr_reader :entry_station

  def initialize(station)
    @entry_station = station
  end

  def record_journey(exit_station)
    @journey = {entry: @entry_station, exit: exit_station}
  end

end
