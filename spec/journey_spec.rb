require "journey.rb"

describe Journey do

subject(:journey) {described_class.new(entry_station)}
let(:entry_station) { double(name: :angel, zone: 1)}
let(:exit_station) { double(name: :waterloo, zone: 1)}

it { is_expected.to respond_to(:record_journey)}

  it "knows the entry the station" do
    expect(journey.entry_station).to eq entry_station
  end

  describe "#record_journey" do
    it "records the beginning and end of a journey" do
      expect(journey.record_journey(exit_station)).to eq ({entry: entry_station, exit: exit_station })
    end
  end



end
