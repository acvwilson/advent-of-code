class Day2
  def calculate(program)
    codes = get_codes(program)
    codes.each_slice(4) do |slice|
      instruction = Instruction.new(slice)
      break if instruction.terminal?

      codes[instruction.location_to_update] = if instruction.addition?
         codes[instruction.location_one] + codes[instruction.location_two]
      else
        codes[instruction.location_one] * codes[instruction.location_two]
      end
    end

    codes.join(",")
  end

  def find_initial_state(state, program)
    program_codes = get_codes(program)
    parameter_limit = [99, program_codes.length - 1].min
    (0..parameter_limit).each do |noun|
      (0..parameter_limit).each do |verb|
        program_codes[1] = noun
        program_codes[2] = verb
        trial_program = program_codes.join(",")
        output = calculate(trial_program)
        if output_matches_state?(output, state)
          return { noun: noun, verb: verb }
        end
      end
    end

    nil
  end

private
  def get_codes(program)
    program.split(",").map(&:to_i)
  end

  def output_matches_state?(output, state)
    output_codes = get_codes(output)
    output_codes.first === state
  end
end

class Instruction
  attr_accessor :opcode
  attr_accessor :location_one
  attr_accessor :location_two
  attr_accessor :location_to_update

  def initialize(input)
    @opcode = input.first
    @location_one = input[1]
    @location_two = input[2]
    @location_to_update = input[3]
  end

  def terminal?
    opcode === 99
  end

  def addition?
    opcode === 1
  end

  def multiplication?
    opcode === 2
  end
end
