
class Oystercard
  attr_reader :balance, :entry_station, :previous_trips


  STARTING_BALANCE = 0
  LIMIT = 90
  MINIMUM = 1

  def initialize(balance = STARTING_BALANCE)
    @balance = balance
    @previous_trips = []
  end

  def top_up(amount)
    raise "Max balance #{LIMIT} exceeded" if (@balance + amount) > LIMIT
    @balance += amount
  end

  def touch_in(station)
    raise "Less than £#{MINIMUM} funds" if @balance < MINIMUM
    @entry_station = station
  end

  def touch_out(station)
    record_journey(entry_station,station)
    deduct(MINIMUM)
    @entry_station = nil
  end

  def in_journey?
    @entry_station != nil
  end


  private
  def deduct(amount)
    @balance -= amount
  end

  def record_journey(entry_station,exit_station)
    journey = {entry: entry_station, exit: exit_station}
    @previous_trips.push(journey)
  end
end
