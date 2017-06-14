
class Oystercard
  attr_reader :balance

  attr_accessor :in_transit

  STARTING_BALANCE = 0
  LIMIT = 90
  MINIMUM = 1

  def initialize(balance = STARTING_BALANCE)
    @balance = balance
    @in_transit = false
  end

  def top_up(amount)
    raise "Max balance #{LIMIT} exceeded" if (@balance + amount) > LIMIT
    @balance += amount
  end

  def touch_in
    raise "Less than £#{MINIMUM} funds" if @balance < MINIMUM
    @in_transit = true
  end

  def touch_out
    @in_transit = false
    deduct(MINIMUM)
  end

  def in_journey?
    in_transit
  end

  private

  def deduct(amount)
    @balance -= amount
  end
end
