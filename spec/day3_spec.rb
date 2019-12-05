require 'day3'

RSpec.describe Day3 do
  it "calculates the nearest intersection to the central port" do
    operator = Day3.new("R8,U5,L5,D3", "U7,R6,D4,L4")
    expect(operator.nearest_intersection_distance).to eq 6

    operator = Day3.new(
      "R75,D30,R83,U83,L12,D49,R71,U7,L72",
      "U62,R66,U55,R34,D71,R55,D58,R83"
    )
    expect(operator.nearest_intersection_distance).to eq 159

    operator = Day3.new(
      "R98,U47,R26,D63,R33,U87,L62,D20,R33,U53,R51",
      "U98,R91,D20,R16,D67,R40,U7,R15,U6,R7"
    )
    expect(operator.nearest_intersection_distance).to eq 135
  end

  it "calculates intersections between paths" do
    operator = Day3.new("R3,U5", "U5,R4")
    expect(operator.intersections).to match_array [
      Coordinate.new(3, 5),
    ]

    operator = Day3.new("R8,U5,L5,D3", "U7,R6,D4,L4")
    expect(operator.intersections).to match_array [
      Coordinate.new(3, 3),
      Coordinate.new(6, 5),
    ]
  end

  it "can calculate the step distance of an intersection" do
    operator = Day3.new("R8,U5,L5,D3", "U7,R6,D4,L4")
    expect(operator.step_distance(Coordinate.new(3, 3))).to eq 40
    expect(operator.step_distance(Coordinate.new(6, 5))).to eq 30
  end

  it "calculates the shortest path distance to an intersection" do
    operator = Day3.new("R8,U5,L5,D3", "U7,R6,D4,L4")
    expect(operator.shortest_path_to_intersection).to eq 30
  end

  it "calculates the coordinates in a path to the right" do
    operator = Day3.new("R1", "R2")
    expect(
      operator.path_one_coordinates
    ).to eq [
      Coordinate.new(0, 0),
      Coordinate.new(1, 0),
    ]

    expect(
      operator.path_two_coordinates
    ).to eq [
      Coordinate.new(0, 0),
      Coordinate.new(1, 0),
      Coordinate.new(2, 0),
    ]
  end

  it "calculates the coordinates in a path to the left" do
    operator = Day3.new("L1", "L2")
    expect(
      operator.path_one_coordinates
    ).to eq [
      Coordinate.new(0, 0),
      Coordinate.new(-1, 0),
    ]

    expect(
      operator.path_two_coordinates
    ).to eq [
      Coordinate.new(0, 0),
      Coordinate.new(-1, 0),
      Coordinate.new(-2, 0),
    ]
  end

  it "calculates the coordinates in a path up" do
    operator = Day3.new("U1", "U2")
    expect(
      operator.path_one_coordinates
    ).to eq [
      Coordinate.new(0, 0),
      Coordinate.new(0, 1),
    ]

    expect(
      operator.path_two_coordinates
    ).to eq [
      Coordinate.new(0, 0),
      Coordinate.new(0, 1),
      Coordinate.new(0, 2),
    ]
  end

  it "calculates the coordinates in a path down" do
    operator = Day3.new("D1", "D2")
    expect(
      operator.path_one_coordinates
    ).to eq [
      Coordinate.new(0, 0),
      Coordinate.new(0, -1),
    ]

    expect(
      operator.path_two_coordinates
    ).to eq [
      Coordinate.new(0, 0),
      Coordinate.new(0, -1),
      Coordinate.new(0, -2),
    ]
  end

  it "calculates the coordinates in a path with multiple instructions" do
    operator = Day3.new("D1,L2", "U2,R1")
    expect(
      operator.path_one_coordinates
    ).to eq [
      Coordinate.new(0, 0),
      Coordinate.new(0, -1),
      Coordinate.new(-1, -1),
      Coordinate.new(-2, -1),
    ]

    expect(
      operator.path_two_coordinates
    ).to eq [
      Coordinate.new(0, 0),
      Coordinate.new(0, 1),
      Coordinate.new(0, 2),
      Coordinate.new(1, 2),
    ]
  end

  it "gets a list of instructions" do
    operator = Day3.new("R8", "U7,R6")
    expect(operator.path_one_instructions.length).to be 1
    expect(operator.path_two_instructions.length).to be 2
    expect(operator.path_one_instructions).to match_array([Instruction.new("R8")])
    expect(operator.path_two_instructions).to match_array([Instruction.new("U7"), Instruction.new("R6")])
  end
end

RSpec.describe Instruction do
  it "knows the direction" do
    expect(Instruction.new("R4").direction).to eq :right
    expect(Instruction.new("U4").direction).to eq :up
    expect(Instruction.new("D4").direction).to eq :down
    expect(Instruction.new("L4").direction).to eq :left
  end

  it "knows the distance" do
    expect(Instruction.new("R4").distance).to be 4
    expect(Instruction.new("U78").distance).to be 78
  end

  it "can compare equality" do
    expect(Instruction.new("L34")).to eq(Instruction.new("L34"))
    expect(Instruction.new("L34")).to_not eq(Instruction.new("R34"))
    expect(Instruction.new("L34")).to_not eq(Instruction.new("L24"))
  end
end

RSpec.describe Coordinate do
  it "can move right" do
    coordinate = Coordinate.new(0, 0)
    coordinate.move_right
    expect(coordinate.x).to eq 1
    expect(coordinate.y).to eq 0
  end

  it "can move left" do
    coordinate = Coordinate.new(0, 0)
    coordinate.move_left
    expect(coordinate.x).to eq -1
    expect(coordinate.y).to eq 0
  end

  it "can move up" do
    coordinate = Coordinate.new(0, 0)
    coordinate.move_up
    expect(coordinate.y).to eq 1
    expect(coordinate.x).to eq 0
  end

  it "can move down" do
    coordinate = Coordinate.new(0, 0)
    coordinate.move_down
    expect(coordinate.y).to eq -1
    expect(coordinate.x).to eq 0
  end

  describe "equality" do
    it "can compare using ==" do
      expect(Coordinate.new(0,0)).to eq(Coordinate.new(0,0))
      expect(Coordinate.new(0,0)).to_not eq(Coordinate.new(1,0))
      expect(Coordinate.new(0,0)).to_not eq(Coordinate.new(0,1))
    end

    it "can compare using #eql?" do
      expect(Coordinate.new(0,0)).to be_eql(Coordinate.new(0,0))
      expect(Coordinate.new(0,0)).to_not be_eql(Coordinate.new(1,0))
      expect(Coordinate.new(0,0)).to_not be_eql(Coordinate.new(0,1))
    end
  end

  it "knows manhattan distance from origin" do
    expect(Coordinate.new(3,4).manhattan_distance).to be 7
    expect(Coordinate.new(-1,-4).manhattan_distance).to be 5
  end
end
