class Graph
  attr_accessor :path_one_instructions
  attr_accessor :path_two_instructions
  attr_accessor :path_one_coordinates
  attr_accessor :path_two_coordinates
  attr_accessor :path_intersections

  def initialize(path_one, path_two)
    @path_one_instructions = path_one.split(",").map { |command| Instruction.new(command) }
    @path_two_instructions = path_two.split(",").map { |command| Instruction.new(command) }
    @path_one_coordinates = coordinates(@path_one_instructions)
    @path_two_coordinates = coordinates(@path_two_instructions)
  end

  def nearest_intersection_distance
    intersections.map { |intersection| intersection.manhattan_distance }.min
  end

  def shortest_path_to_intersection
    intersections.map { |intersection| step_distance(intersection) }.min
  end

  def intersections
    # (path_one_coordinates & path_two_coordinates) - [Coordinate.new(0, 0)]
    self.path_intersections ||= path_one_coordinates.select do |coordinate|
      path_two_coordinates.include?(coordinate)
    end - [Coordinate.new(0, 0)]
  end

  def step_distance(intersection)
    path_one_coordinates.index(intersection) + path_two_coordinates.index(intersection)
  end

private
  def coordinates(path_instructions)
    coordinates = [Coordinate.new(0, 0)]
    path_instructions.each_with_index do |instruction, i|
      instruction.distance.times do
        coordinates.push coordinates[-1].clone.send("move_#{instruction.direction}")
      end
    end

    coordinates
  end
end

class Instruction
  attr_accessor :direction
  attr_accessor :distance

  DIRECTION = {
    "R" => :right,
    "L" => :left,
    "U" => :up,
    "D" => :down
  }

  def initialize(input)
    direction, *distance = input.chars
    @direction = DIRECTION[direction]
    @distance = distance.join.to_i
  end

  def ==(other_instruction)
    direction == other_instruction.direction && distance == other_instruction.distance
  end
end

class Coordinate
  attr_accessor :x
  attr_accessor :y

  def initialize(x, y)
    @x = x
    @y = y
  end

  def move_right
    self.x += 1
    self
  end

  def move_left
    self.x -= 1
    self
  end

  def move_up
    self.y += 1
    self
  end

  def move_down
    self.y -= 1
    self
  end

  def manhattan_distance
    x.abs + y.abs
  end

  def ==(other_coordinate)
    x == other_coordinate.x && y == other_coordinate.y
  end

  def eql?(other_coordinate)
    self == other_coordinate
  end

  def to_s
    "{x: #{x}, y: #{y}}"
  end
end
