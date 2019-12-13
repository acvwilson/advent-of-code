require 'day2/intcode_computer'

RSpec.describe IntcodeComputer do
  let(:operator) { IntcodeComputer.new }

  it "stops on 99" do
    expect(operator.calculate("99")).to eq("99")
    expect(operator.calculate("1,0,0,2,99,2,0,2,7")).to eq "1,0,2,2,99,2,0,2,7"

  end

  it "calculates 1 operator as adding" do
    expect(operator.calculate("1,0,0,0")).to eq "2,0,0,0"
    expect(operator.calculate("1,0,0,1")).to eq "1,2,0,1"
    expect(operator.calculate("1,3,0,3")).to eq "1,3,0,4"
  end

  it "calculates 2 operator as multiplying" do
    expect(operator.calculate("2,0,0,0")).to eq "4,0,0,0"
    expect(operator.calculate("2,0,0,1")).to eq "2,4,0,1"
    expect(operator.calculate("2,3,0,3")).to eq "2,3,0,6"
  end

  it "handles multiple codes" do
    expect(operator.calculate("1,0,0,0,2,0,0,0")).to eq "4,0,0,0,2,0,0,0"
    expect(operator.calculate("1,0,0,2,2,0,2,7")).to eq "1,0,2,2,2,0,2,2"
  end

  it "can handle the examples given on the website" do
    expect(operator.calculate("1,9,10,3,2,3,11,0,99,30,40,50")).to eq "3500,9,10,70,2,3,11,0,99,30,40,50"
    expect(operator.calculate("1,1,1,4,99,5,6,0,99")).to eq "30,1,1,4,2,5,6,0,99"
  end

  it "can find a way to get an initial state given a program" do
    expect(operator.find_initial_state(1, "1,0,0,2,2,0,2,7")).to eq({ noun: 0, verb: 0 })
    expect(operator.find_initial_state(2, "1,0,0,2,2,0,2,7")).to eq nil
    expect(
      operator.find_initial_state(1, "1,0,0,2,2,0,2,0")
    ).to eq({ noun: 0, verb: 1 })
    expect(
      operator.find_initial_state(4, "1,0,0,2,2,0,2,0")
    ).to eq({ noun: 2, verb: 2 })
  end
end
