require "journey.rb"

describe Journey do

subject(:journey) {described_class.new(entry_station)}
let(:entry_station) { double(name: :angel, zone: 1)}
let(:exit_station) { double(name: :waterloo, zone: 1)}

it { is_expected.to respond_to(:set_exit_station) }

  it "knows the entry the station" do
    expect(journey.entry_station).to eq entry_station
  end

  it "has an exit station" do
    expect(journey.exit_station).to eq nil
  end

  describe "#set_exit_station" do
    it "sets the exit station once the journey has been completed" do
      journey.set_exit_station(entry_station)
      expect(journey.exit_station).to eq entry_station
    end
  end
end
