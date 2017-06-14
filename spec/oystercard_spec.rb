
require 'oystercard'


describe Oystercard do
  let(:station) { double(:angel) }
  let(:exit_station) { double(:waterloo) }
  let(:journey) { double(:journey, :entry => :angel, :exit => :waterloo) }

  subject(:card) { described_class.new(1) }


  describe 'attributes' do
    card2 = Oystercard.new
    it { is_expected.to respond_to(:balance) }
    it { is_expected.to respond_to(:entry_station) }
    it { is_expected.to respond_to(:touch_out).with(1).argument}
    it { is_expected.to respond_to(:touch_in).with(1).argument}
    it { is_expected.to respond_to(:previous_trips) }
    it { is_expected.to respond_to(:journey) }


    describe "#previous_trips" do
      it "starts with an empty list of journeys" do
        expect(card.previous_trips).to eq []
      end
    end

    it 'should have a balance when initialized' do
      expect(card2.balance).to eq 0
    end
  end

  describe '#top_up' do
    it 'should add the argument to the balance' do
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
        expect(card.journey).to be_an_instance_of(Journey)
      end

      it "should be in journey" do

        card.touch_in(station)
        expect(card).to be_in_journey
      end

      context 'when balance below £1' do
        before do
          card.touch_in(station)
          card.touch_out(exit_station)
        end

        it 'raises an error' do
          expect { card.touch_in(station) }.to raise_error("Less than £#{Oystercard::MINIMUM} funds")
        end
      end
    end

  end


  describe '#touch_out' do
    context "when journey ends" do
      before do
        card.touch_in(station)
        card.touch_out(exit_station)
      end

      pending "should not be @in_journey" do
        expect(card).not_to be_in_journey
      end

      it 'charges the card' do
        expect { card.touch_out(exit_station) }.to change { card.balance }.from(card.balance).to(card.balance - Oystercard::MINIMUM)
      end

      it "deletes the entry station" do
        expect(card.entry_station).to eq nil
      end

      it "should add our journey to previous trips" do
        expect(card.previous_trips.last).to eq ({entry: station, exit: exit_station})
      end
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




end
