class Journey
attr_reader :entry_station, :exit_station

NORMAL = 1
PENALTY = 6

  def initialize(entry_station = nil, exit_station = nil)
    @entry_station = entry_station
    @exit_station = exit_station
  end

  def start(entry_station)
    @entry_station = entry_station
  end

  def finish(exit_station)
    @exit_station = exit_station
  end

  def complete?
    !!entry_station && exit_station
  end

  def fare
    if complete?
      NORMAL
    else
      PENALTY
    end
  end

end
