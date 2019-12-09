require 'day4'

RSpec.describe Day4 do
  let(:operator) { operator = Day4.new }

  it "knows if a string is a valid password option" do
    expect(operator.valid?("1234")).to be_falsy
    expect(operator.valid?("12334")).to be_truthy
    expect(operator.valid?("12331")).to be_falsy
  end

  it "knows if the password is increasing" do
    expect(operator.increasing?("1234")).to be_truthy
    expect(operator.increasing?("1234321")).to be_falsy
  end

  it "knows how many valid passwords in a range" do
    expect(operator.valid_password_count(121..135)).to eq 2

    expect(operator.valid_password_count(1221..1233)).to eq 8
  end

  it "knows if a string has repeats" do
    expect(operator.has_duplicate_characters?("111122")).to be_truthy
    expect(operator.has_duplicate_characters?("99")).to be_truthy
    expect(operator.has_duplicate_characters?("1111")).to be_falsy
    expect(operator.has_duplicate_characters?("1234")).to be_falsy
  end
end
