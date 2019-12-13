require "day1/Ship"

RSpec.describe Ship do
  let(:operator) { Ship.new }

  it "calculates the fuel needed for a module's mass" do
    expect(operator.fuel_requirement_for(12)).to eq 2
    expect(operator.fuel_requirement_for(14)).to eq 2
    expect(operator.fuel_requirement_for(1969)).to eq 966
    expect(operator.fuel_requirement_for(100756)).to eq 50346
  end

  it "the minimum fuel requirement is 0" do
    expect(operator.fuel_requirement_for(4)).to eq 0
  end

  it "calculate sum of the fuel requirements for the modules" do
    expect(operator.sum_of_fuel_requirements([12])).to eq 2
    expect(operator.sum_of_fuel_requirements([12, 24, 600])).to eq 293
  end
end
