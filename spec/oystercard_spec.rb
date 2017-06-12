
require "oystercard"

describe Oystercard do

  subject(:card) { described_class.new }

  describe "attributes" do
    it {is_expected.to respond_to(:balance)}

    it "should have a balance when initialized" do
      expect(card.balance).to eq 0
    end

  end

end
