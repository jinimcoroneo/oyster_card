
require 'oystercard'

describe Oystercard do
  let(:station) { double(:angel) }
  subject(:card) { described_class.new }

  describe 'attributes' do
    card2 = Oystercard.new
    it { is_expected.to respond_to(:balance) }
    it { is_expected.to respond_to(:entry_station) }
    it { is_expected.to respond_to(:touch_in).with(1).argument}

    it 'should have a balance when initialized' do
      expect(card2.balance).to eq 0
    end
  end

  before do
    card.top_up(2)
  end

  describe '#top_up' do
    it 'should add the argument to the balance' do
      expect { card.top_up(5) }.to change { card.balance }.from(2).to(7)
    end

    it 'raises error if max balance exceeded' do
      over_limit = Oystercard::LIMIT + 1
      expect { card.top_up(over_limit) }.to raise_error("Max balance #{Oystercard::LIMIT} exceeded")
    end
  end

  describe '#touch_in' do
    it "should be in journey" do
      card.touch_in(station)
      expect(card).to be_in_journey
    end

    context 'when balance below £1' do
      before do
        card.touch_out
        card.touch_out
      end

      it 'raises an error' do
        expect { card.touch_in(station) }.to raise_error("Less than £#{Oystercard::MINIMUM} funds")
      end
    end
  end

  describe '#touch_out' do
    before do
      card.touch_in(station)
    end

    it "should not be @in_journey" do
      card.touch_out
      expect(card).not_to be_in_journey
    end

    it 'charges the card' do
      expect { card.touch_out }.to change { card.balance }.from(card.balance).to(card.balance - Oystercard::MINIMUM)
    end

    it "deletes the entry station" do
      card.touch_out
      expect(card.entry_station).to eq nil
    end
  end

  describe '#in_journey?' do
    context 'when user is in transit' do
      before do
        card.touch_in(station)
      end

      it 'returns true' do
        expect(card).to be_in_journey
      end
    end

    context 'when user is not in transit' do
      it 'returns false' do
        expect(card).not_to be_in_journey
      end
    end
  end

  describe "#entry_station" do
    it "returns the entry station" do
      card.touch_in(station)
      expect(card.entry_station).to eq station
    end
  end


end
