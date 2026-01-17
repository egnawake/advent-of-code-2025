require_relative "cli"

class Point
  attr_reader :x, :y

  def initialize(x, y)
    @x = x
    @y = y
  end

  def to_s
    "(#{x}, #{y})"
  end
end

class Rect
  attr_reader :corners

  def initialize(corners)
    @corners = corners
  end

  def area
    width = (@corners[0].x - @corners[1].x).abs + 1
    height = (@corners[0].y - @corners[1].y).abs + 1
    width * height
  end

  def to_s
    "[#{corners[0]}, #{corners[1]}]"
  end
end

class Day09Solver
  def initialize(input_stream)
    @input_stream = input_stream
  end

  def parse_points
    @input_stream.readlines.map do |line|
      coords = line.split(",").map { Integer(_1) }
      Point.new(*coords)
    end
  end

  def all_rects(points)
    points.combination(2).map { |pair| Rect.new(pair) }
  end

  def part_one
    red_tiles = parse_points
    all_rects(red_tiles).map(&:area).max
  end

  def intersects_rect?(rect, line)
    is_to_left = line[0].x <= rect.corners[0].x &&
      line[0].x <= rect.corners[1].x &&
      line[1].x <= rect.corners[0].x &&
      line[1].x <= rect.corners[1].x
    is_to_right = line[0].x >= rect.corners[0].x &&
      line[0].x >= rect.corners[1].x &&
      line[1].x >= rect.corners[0].x &&
      line[1].x >= rect.corners[1].x
    is_above = line[0].y <= rect.corners[0].y &&
      line[0].y <= rect.corners[1].y &&
      line[1].y <= rect.corners[0].y &&
      line[1].y <= rect.corners[1].y
    is_below = line[0].y >= rect.corners[0].y &&
      line[0].y >= rect.corners[1].y &&
      line[1].y >= rect.corners[0].y &&
      line[1].y >= rect.corners[1].y
    is_outside = is_to_left || is_to_right || is_above || is_below

    !is_outside
  end

  def part_two
    red_tiles = parse_points

    polygon_lines = (red_tiles.length - 1).times
      .map { |i| [red_tiles[i], red_tiles[i + 1]] } <<
      [red_tiles[-1], red_tiles[0]]

    all_rects(red_tiles).filter do |rect|
      polygon_lines.none? do |line|
        intersects_rect?(rect, line)
      end
    end.sort_by { |rect| rect.area }.reverse.first.area
  end
end

CLI.new(Day09Solver).start
