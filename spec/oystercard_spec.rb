
require "oystercard"

describe Oystercard do

  subject(:card) { described_class.new }

  describe "attributes" do
    it {is_expected.to respond_to(:balance)}

    it "should have a balance when initialized" do
      expect(card.balance).to eq 0
    end
  end

  describe "#top_up" do
    it "should add the argument to the balance" do
      expect{ card.top_up(5) }.to change{ card.balance }.from(0).to(5)
      end

    it "raises error if max balance exceeded" do
      over_limit = Oystercard::LIMIT + 1
      expect { card.top_up(over_limit) }.to raise_error("Max balance #{Oystercard::LIMIT} exceeded")
    end
  end

end
