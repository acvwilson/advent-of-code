class Day2
  def calculate(intcode)
    codes = intcode.split(",").map(&:to_i)
    codes.each_slice(4) do |slice|
      break if slice.first === 99

      if slice.first === 1
        codes[slice[3]] = codes[slice[1]] + codes[slice[2]]
      else
        codes[slice[3]] = codes[slice[1]] * codes[slice[2]]
      end
    end

    codes.join(",")
  end
end
