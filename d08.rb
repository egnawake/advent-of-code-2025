require "set"

class Point
  attr_reader :x, :y, :z

  def initialize(x, y, z)
    @x = Integer(x)
    @y = Integer(y)
    @z = Integer(z)
  end

  def distance_to(other)
    dx = other.x - x
    dy = other.y - y
    dz = other.z - z

    Math::sqrt(dx * dx + dy * dy + dz * dz)
  end

  def to_s
    "(#{x}, #{y}, #{z})"
  end
end

def read_box_locations
  locations = []
  while (line = gets)
    locations << Point.new(*line.chomp.split(","))
  end
  locations
end

def get_distances(points)
  distances = Hash.new

  points.each do |p|
    points.each do |other|
      unless p == other || distances.include?(Set[p, other])
        distances[Set[p, other]] = p.distance_to(other)
      end
    end
  end

  distances
end

def build_circuits(locations)
  # Initialize circuits with single-box sets
  circuits = locations.map { |loc| Set[loc] }

  distances = get_distances(locations)
  pairs_by_distance = distances.each_key.sort_by { |k| distances[k] }

  Enumerator.produce([circuits, pairs_by_distance]) do |circuits, pairs|
    pair = pairs[0]
    to_merge, rest = circuits.partition { |c| c.intersect?(pair) }

    [[to_merge.reduce(:+)] + rest, pairs[1..]]
  end.lazy.map { |circuits, pairs| [circuits, pairs[0]] }
end

def solve_part_one
  circuits, pair = build_circuits(read_box_locations).drop(1000).first
  circuits.map { |c| c.size }.max(3).reduce(:*)
end

def solve_part_two
  last_pair = nil
  build_circuits(read_box_locations)
    .take_while { |c, p| c.length > 1 }
    .each do |circuits, pair|
      last_pair = pair
    end

  last_pair.map { |p| p.x }.reduce(:*)
end

part = ARGV.shift
if part == "2"
  puts solve_part_two
else
  puts solve_part_one
end
