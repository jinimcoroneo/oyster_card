
require_relative "station.rb"
require_relative "journey.rb"

class Oystercard
  attr_reader :balance, :entry_station, :previous_trips, :journey


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
    #@entry_station = station #need to remove
    @journey = Journey.new(station)
  end

  def touch_out(station)
    var = @journey.record_journey(station)
    @previous_trips.push(var)
    deduct(MINIMUM)
  end

  def in_journey?
    @journey != nil
  end


  private
  def deduct(amount)
    @balance -= amount
  end

end
