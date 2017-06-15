
require_relative "station.rb"
require_relative "journey.rb"

class Oystercard
  attr_reader :balance, :journey_history, :new_journey

  STARTING_BALANCE = 0
  LIMIT = 90
  MINIMUM = 1

  def initialize(balance = STARTING_BALANCE)
    @balance = balance
    @journey_history = []
  end

  def top_up(amount)
    raise "Max balance #{LIMIT} exceeded" if (@balance + amount) > LIMIT
    @balance += amount
  end

  def touch_in(entry_station)
    raise "Less than £#{MINIMUM} funds" if @balance < MINIMUM
    new_journey_start(entry_station)
  end

  def new_journey_start(entry_station)
    @new_journey = Journey.new(entry_station)
  end

  def touch_out(exit_station)
    @new_journey.set_exit_station(exit_station)
    deduct(MINIMUM)
    store_journey
  end

  def store_journey
    @journey_history << @new_journey
  end

  def in_journey?
    @journey != nil
  end


  private
  def deduct(amount)
    @balance -= amount
  end

end
