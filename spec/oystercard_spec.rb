
require 'oystercard'


describe Oystercard do
  let(:station) { double(:angel) }
  let(:exit_station) { double(:waterloo) }
  let(:journey) { double(:journey, :entry => :angel, :exit => :waterloo) }

  subject(:card) { described_class.new(1) }

  card2 = Oystercard.new

  describe "#initialize" do

    it "starts with an empty list of journeys" do
      expect(card.journey_history).to eq []
    end

    it 'should have a balance when initialized' do
      expect(card2.balance).to eq 0
    end
  end

  describe '#top_up' do
    it 'should add the amount to the balance' do
      expect { card.top_up(5) }.to change { card.balance }.from(1).to(6)
    end

    it 'raises error if max balance exceeded' do
      over_limit = Oystercard::LIMIT + 1
      expect { card.top_up(over_limit) }.to raise_error("Max balance #{Oystercard::LIMIT} exceeded")
    end
  end

  describe '#touch_in' do

    context "when journey starts" do

      it "should create a new journey" do
        card.touch_in(station)
        expect(card.new_journey).to be_an_instance_of(Journey)
      end

      it "should be in journey" do
        card.touch_in(station)
        expect(card).to be_in_journey
      end

      it 'raises an error' do
        expect { card2.touch_in(station) }.to raise_error("Less than £#{Oystercard::MINIMUM} funds")
      end
    end
  end

  describe '#touch_out' do
    context "when journey ends" do
      before do
        card.touch_in(station)
      end

      it 'charges the card' do
        expect { card.touch_out(exit_station) }.to change { card.balance }.by(- Oystercard::MINIMUM)
      end

      it "should add our journey to journey history" do
        card.touch_out(exit_station)
        expect(card.journey_history.last).to eq (card.new_journey)
      end
    end
  end

  describe '#in_journey?' do

    before do
      card.touch_in(station)
    end

    context 'when user is in transit' do

      it 'returns true' do
        expect(card).to be_in_journey
      end
    end

    context 'when user is not in transit' do
      it 'returns false' do
        card.touch_out(exit_station)
        expect(card).not_to be_in_journey
      end
    end
  end
end
