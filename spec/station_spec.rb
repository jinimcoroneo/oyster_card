require "station.rb"

describe Station do
  subject(:station) { described_class.new(name: :angel, zone: 1) }

  describe "attributes" do
    it "knows its name" do
      expect(station.name).to eq :angel
    end
    it "knows its zone" do
      expect(station.zone).to eq 1
    end
  end


end
