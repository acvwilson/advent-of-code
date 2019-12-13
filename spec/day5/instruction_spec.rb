require 'day5/instruction'

RSpec.describe Instruction do
  it "knows if it's terminal" do
    instruction = Instruction.new(["99"])
    expect(instruction).to be_terminal
  end

  it "knows if it's an addition instruction" do
    instruction = Instruction.new(["1"])
    expect(instruction).to be_addition
    instruction = Instruction.new(["101"])
    expect(instruction).to be_addition
  end

  it "knows if it's a multiplication instruction" do
    instruction = Instruction.new(["2"])
    expect(instruction).to be_multiplication
    instruction = Instruction.new(["102"])
    expect(instruction).to be_multiplication
  end

  it "knows if it's an input instruction" do
    instruction = Instruction.new(["3"])
    expect(instruction).to be_input
  end

  it "knows if it's an output instruction" do
    instruction = Instruction.new(["4"])
    expect(instruction).to be_output
  end

  it "knows if it's a jump if true instruction" do
    instruction = Instruction.new(["5"])
    expect(instruction).to be_jump_if_true
  end

  it "knows if it's a jump if false instruction" do
    instruction = Instruction.new(["6"])
    expect(instruction).to be_jump_if_false
  end

  it "knows if it's a less than instruction" do
    instruction = Instruction.new(["7"])
    expect(instruction).to be_less_than
  end

  it "knows if it's a both equal instruction" do
    instruction = Instruction.new(["8"])
    expect(instruction).to be_both_equal
  end

  describe "parameters" do
    it "know their type is position by default" do
      instruction = Instruction.new(["2", "1", "3", "0"])
      expect(instruction.parameter_one[:kind]).to eq :position
      expect(instruction.parameter_two[:kind]).to eq :position
    end

    it "know their value" do
      instruction = Instruction.new(["2", "1", "3", "0"])
      expect(instruction.parameter_one[:value]).to eq 1
      expect(instruction.parameter_two[:value]).to eq 3
    end

    it "know their type is immediate if specified" do
      instruction = Instruction.new(["1102", "1", "3", "0"])
      expect(instruction.parameter_one[:kind]).to eq :immediate
      expect(instruction.parameter_two[:kind]).to eq :immediate
      instruction = Instruction.new(["104", "3"])
      expect(instruction.parameter_one[:kind]).to eq :immediate
    end

    it "know their type when mixed" do
      instruction = Instruction.new(["101", "-1", "3", "0"])
      expect(instruction.parameter_one[:kind]).to eq :immediate
      expect(instruction.parameter_two[:kind]).to eq :position
    end

    it "knows it's location to update" do
      instruction = Instruction.new(["02", "1", "3", "0"])
      expect(instruction.location).to eq 0
      instruction = Instruction.new(["3", "1"])
      expect(instruction.location).to eq 1
    end
  end
end
