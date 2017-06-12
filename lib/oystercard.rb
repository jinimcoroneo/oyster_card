
class Oystercard
attr_reader :balance
STARTING_BALANCE = 0
LIMIT = 90

def initialize(balance = STARTING_BALANCE)
  @balance = balance
end

def top_up(amount)
  raise "Max balance #{LIMIT} exceeded" if ((@balance + amount) > LIMIT)
  @balance += amount
end


end
