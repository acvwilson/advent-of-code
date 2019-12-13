require 'day5/intcode_computer'

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

  it "can handle immediate values" do
    expect(operator.calculate("101,-1,0,0")).to eq "100,-1,0,0"
    expect(operator.calculate("101,-1,0,0,102,0,0,0")).to eq "0,-1,0,0,102,0,0,0"
  end

  it "can handle input values" do
    expect(operator.calculate("3,0", "1")).to eq "1,0"
    expect(operator.calculate("3,2,102,0,0,0", "1")).to eq "6,2,1,0,0,0"
  end

  it "can handle output values" do
    operator.calculate("4,0")
    expect(operator.output).to eq ["4"]
    operator.calculate("101,-1,0,0,4,0,102,0,0,0,4,1")
    expect(operator.output).to eq ["100", "-1"]
  end

  it "can handle equal to operations" do
    operator.calculate("3,9,8,9,10,9,4,9,99,-1,8")
    expect(operator.output).to eq ["0"]
    operator.calculate "3,3,1108,-1,8,3,4,3,99"
    expect(operator.output).to eq ["0"]
  end

  it "can handle less than operations" do
    operator.calculate "3,9,7,9,10,9,4,9,99,-1,8"
    expect(operator.output).to eq ["1"]
    operator.calculate "3,3,1107,-1,8,3,4,3,99"
    expect(operator.output).to eq ["1"]
  end

  it "can handle jumping" do
    operator.calculate "3,12,6,12,15,1,13,14,13,4,13,99,-1,0,1,9", "1"
    expect(operator.output).to eq ["1"]
  end

  it "can handle the examples given on the website" do
    expect(operator.calculate("1,9,10,3,2,3,11,0,99,30,40,50")).to eq "3500,9,10,70,2,3,11,0,99,30,40,50"
    expect(operator.calculate("1,1,1,4,99,5,6,0,99")).to eq "30,1,1,4,2,5,6,0,99"
  end

  it "can hande output example from the website" do
    operator.calculate(
      "3,21,1008,21,8,20,1005,20,22,107,8,21,20,1006,20,31,1106,0,36,98,0,0,1002,21,125,20,4,20,1105,1,46,104,999,1105,1,46,1101,1000,1,20,4,20,1105,1,46,98,99",
      "1"
    )
    expect(operator.output).to eq ["999"]

    operator.calculate(
      "3,21,1008,21,8,20,1005,20,22,107,8,21,20,1006,20,31,1106,0,36,98,0,0,1002,21,125,20,4,20,1105,1,46,104,999,1105,1,46,1101,1000,1,20,4,20,1105,1,46,98,99",
      "8"
    )
    expect(operator.output).to eq ["1000"]

    operator.calculate(
      "3,21,1008,21,8,20,1005,20,22,107,8,21,20,1006,20,31,1106,0,36,98,0,0,1002,21,125,20,4,20,1105,1,46,104,999,1105,1,46,1101,1000,1,20,4,20,1105,1,46,98,99",
      "99"
    )
    expect(operator.output).to eq ["1001"]
  end
end
