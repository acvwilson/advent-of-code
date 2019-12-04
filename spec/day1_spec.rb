require 'day1'

RSpec.describe Day1 do
  let(:operator) { Day1.new }

  it "calculates fuel needs" do
    expect(operator.calculate(12)).to eq 2
    expect(operator.calculate(14)).to eq 2
    expect(operator.calculate(1969)).to eq 654
    expect(operator.calculate(100756)).to eq 33583
  end
end
