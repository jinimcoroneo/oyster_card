require "journey.rb"

describe Journey do

subject(:journey) {described_class.new()}
let(:entry_station) { double("Bank")}
let(:exit_station) { double("Aldgate")}

  describe "attributes" do
     describe "entry_station" do
       it "will default to nil if nothing provided at init" do
         expect(journey.entry_station).to be nil
       end
      context "when entry_station provided" do
         it "stores it" do
           journey.start(entry_station)
           expect(journey.entry_station).to be entry_station
         end
       end
     end
    describe "exit_station" do
      it "will default to nil if nothing provided at init" do
        expect(journey.exit_station).to be nil
      end
      context "when exit_station provided" do
        it "stores it" do
           journey.finish(exit_station)
           expect(journey.exit_station).to be exit_station
        end
      end
    end
  end

  describe '#complete?' do
    context "when there is a full journey" do
      before do
        journey.start(entry_station)
        journey.finish(exit_station)
      end
        it "returns true" do
          expect(journey).to be_complete
        end
    end
    context "when there is no entry_station" do
      before do
        journey.finish(exit_station)
      end
        it "returns false" do
          expect(journey).not_to be_complete
        end
    end
    context "when there is no exit_station" do
      before do
        journey.start(entry_station)
      end
        it "returns false" do
          expect(journey).not_to be_complete
        end
    end
  end

  describe '#fare' do
    context "when there is a full journey" do
      before do
        journey.start(entry_station)
        journey.finish(exit_station)
      end
      it "charges the normal fare" do
        expect(journey.fare).to eq(Journey::NORMAL)
      end
  end
    context "when there is no exit_station" do
      before do
        journey.start(entry_station)
      end
      it "charges the penalty fare" do
        expect(journey.fare).to eq(Journey::PENALTY)
      end
    end

    context "when there is no entry_station" do
      before do
        journey.finish(exit_station)
      end
      it "charges the penalty fare" do
        expect(journey.fare).to eq(Journey::PENALTY)
      end
    end
  end
end
