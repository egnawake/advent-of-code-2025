require "set"

def read_data(filename)
  ranges = []
  ids = []

  state = :range
  File.open(filename) do |f|
    f.each_line(chomp: true) do |line|
      if state == :range
        if line.size == 0
          state = :id
        else
          range = line.split("-").map { |bound| bound.to_i }
          ranges << range
        end
      elsif state == :id
        ids << line.to_i
      end
    end
  end

  return {ranges:, ids:}
end

def solve_part_one(data)
  data[:ids].select do |id|
    data[:ranges].any? { |range| id >= range[0] && id <= range[1] }
  end.size
end

def add_and_merge(arr, new_range)
  (no_overlaps, overlaps) = arr.partition do |range|
    new_range[0] > range[1] || new_range[1] < range[0]
  end
  result = no_overlaps
  if overlaps.size == 0
    result << new_range
  else
    overlaps = [new_range] + overlaps
    lower = overlaps.map { |r| r[0] }.min
    upper = overlaps.map { |r| r[1] }.max
    result << [lower, upper]
  end
  result
end

def solve_part_two(data)
  result = []
  data[:ranges].each do |range|
    result = add_and_merge(result, range)
  end
  result.map { |r| r[1] - r[0] + 1 }.sum
end

data = read_data("input/d05")
if ARGV[0] == "2"
  puts solve_part_two(data)
else
  puts solve_part_one(data)
end
