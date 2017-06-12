
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

  describe "#deduct" do

    before do
      card.top_up(10)
    end

     it "will deduct the amount passed from balance" do
       expect { card.deduct(5) }.to change { card.balance }.from(10).to(5)
     end

  end

  describe "#touch_in" do

    #set up so that card has money.

    it "changes @in_transit to \'true\'" do
       expect { card.touch_in }.to change { card.in_transit}.from(false).to(true)
    end
  end

  describe "#touch_out" do

    before do
      card.touch_in
    end

    it "changes @in_transit to \'false\'" do
       expect { card.touch_out }.to change { card.in_transit}.from(true).to(false)
    end


  end

  describe "#in_journey?" do

    context "when user is in transit" do

      before do
        card.touch_in
      end

      it "returns true" do
        expect(card).to be_in_journey
      end

    end

    context "when user is not in transit" do

      it "returns false" do
        expect(card).not_to be_in_journey
      end

    end



  end








end
