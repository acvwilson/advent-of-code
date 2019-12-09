class Day4
  def valid_password_count(range)
    range.select { |number| valid?(number.to_s) }.count
  end

  def valid?(password)
    has_duplicate_characters?(password) && increasing?(password)
  end

  def increasing?(password)
    password.chars.sort_by(&:to_i).join == password
  end

  def has_duplicate_characters?(password)
    ("0".."9").any? do |number|
      password.count(number) == 2
    end
  end
end
