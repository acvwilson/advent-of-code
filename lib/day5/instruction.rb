class Instruction
  attr_accessor :opcode
  attr_accessor :parameter_one
  attr_accessor :parameter_two
  attr_accessor :location

  KIND = {
    "0" => :position,
    "1" => :immediate
  }

  OPCODE = {
    1 => :addition,
    2 => :multiplication,
    3 => :input,
    4 => :output,
    5 => :jump_if_true,
    6 => :jump_if_false,
    7 => :less_than,
    8 => :both_equal,
    99 => :terminal
  }

  def initialize(input)
    @opcode = OPCODE[(input.first[-2..-1] || input.first).to_i]
    if @opcode == :input
      @location = input[1].to_i
    elsif @opcode == :output
      @parameter_one = { value: input[1].to_i, kind: KIND[input.first[-3]] || :position }
    elsif @opcode != :terminal
      @parameter_one = { value: input[1].to_i, kind: KIND[input.first[-3]] || :position }
      @parameter_two = { value: input[2].to_i, kind: KIND[input.first[-4]] || :position }
      @location = input[3].to_i
    end
  end

  def terminal?
    self.opcode == :terminal
  end

  def addition?
    self.opcode == :addition
  end

  def multiplication?
    self.opcode == :multiplication
  end

  def input?
    self.opcode == :input
  end

  def output?
    self.opcode == :output
  end

  def jump_if_true?
    self.opcode == :jump_if_true
  end

  def jump_if_false?
    self.opcode == :jump_if_false
  end

  def less_than?
    self.opcode == :less_than
  end

  def both_equal?
    self.opcode == :both_equal
  end
end
