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
           journey.start(exit_station)
           expect(journey.exit_station).to be exit_station
         end

        end

      end

end


end

end
