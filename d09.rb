require_relative "cli"

class Rect
  attr_reader :corners

  def initialize(corners)
    @corners = corners
  end

  def area
    width = (@corners[0][0] - @corners[1][0]).abs + 1
    height = (@corners[0][1] - @corners[1][1]).abs + 1
    width * height
  end
end

class Day09Solver
  def initialize(input_stream)
    @input_stream = input_stream
  end

  def parse_points
    @input_stream.readlines.map do |line|
      line.split(",").map { Integer(_1) }
    end
  end

  def all_rects(points)
    red_tiles.combination(2)
  end

  def part_one
    red_tiles = parse_points
    all_rects(red_tiles).map { Rect.new(_1).area }.max
  end

  def part_two
    red_tiles = parse_points
    all_rects(red_tiles).filter do |rect|
      # TODO: select rects that intersect with polygon
    end
  end
end

CLI.new(Day09Solver).start
