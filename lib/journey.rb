class Journey
attr_accessor :entry_station, :exit_station


  def initialize(entry_station, exit_station = nil)
    @entry_station = entry_station
    @exit_station = exit_station
  end

  def set_exit_station(exit_station)
    @exit_station = exit_station
  end

end
