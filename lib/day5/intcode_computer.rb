require './lib/day5/instruction'

class IntcodeComputer
  attr_accessor :output

  def calculate(program, system_id = nil)
    self.output = []
    position = 0
    codes = get_codes(program)

    until position >= codes.length do
      slice = codes[position...(position + 4)]
      instruction = Instruction.new(slice)
      break if instruction.terminal?

      if instruction.addition? || instruction.multiplication? || instruction.both_equal? || instruction.less_than? || instruction.jump_if_true? || instruction.jump_if_false?
        parameter_one = instruction.parameter_one[:kind] == :immediate ? instruction.parameter_one[:value] : codes[instruction.parameter_one[:value]].to_i
        parameter_two = instruction.parameter_two[:kind] == :immediate ? instruction.parameter_two[:value] : codes[instruction.parameter_two[:value]].to_i
        codes[instruction.location] = if instruction.addition?
          position += 4
          (parameter_one + parameter_two).to_s
        elsif instruction.multiplication?
          position += 4
          (parameter_one * parameter_two).to_s
        elsif instruction.both_equal?
          position += 4
          parameter_one === parameter_two ? "1" : "0"
        elsif instruction.less_than?
          position += 4
          parameter_one.to_i < parameter_two.to_i ? "1" : "0"
        elsif instruction.jump_if_true?
          if parameter_one.zero?
            position += 3
          else
            position = parameter_two.to_i
          end
        elsif instruction.jump_if_false?
          if parameter_one.zero?
            position = parameter_two.to_i
          else
            position += 3
          end
        end
      elsif instruction.input?
        codes[instruction.location] = system_id

        position += 2
      elsif instruction.output?
        parameter_one = instruction.parameter_one[:kind] == :immediate ? instruction.parameter_one[:value] : codes[instruction.parameter_one[:value]].to_i
        output << parameter_one.to_s

        position += 2
      else
        raise "Can't do that"
      end
    end

    codes.join(",")
  end

private
  def get_codes(program)
    program.split(",")
  end
end
