
class Oystercard
  attr_reader :balance, :entry_station


  STARTING_BALANCE = 0
  LIMIT = 90
  MINIMUM = 1

  def initialize(balance = STARTING_BALANCE)
    @balance = balance
  end

  def top_up(amount)
    raise "Max balance #{LIMIT} exceeded" if (@balance + amount) > LIMIT
    @balance += amount
  end

  def touch_in(station)
    raise "Less than £#{MINIMUM} funds" if @balance < MINIMUM
    @entry_station = station
  end

  def touch_out
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
end
