def solve_part_one(manifold)
  beams = []
  splits = 0

  beams << manifold[0].index("S")

  manifold[1..].each do |row|
    row.each_char.with_index do |col, i|
      if col == "^" && beams.include?(i)
        splits += 1

        beams = beams.reject { |b| b == i }

        left = i - 1
        beams << left if left >= 0
        right = i + 1
        beams << right if right < row.length
      end
    end
  end

  splits
end

def quantum_splits(manifold, col)
  if manifold.length == 0 || col < 0 || col >= manifold[0].length
    return 1
  end

  if manifold[0][col] == "^"
    return quantum_splits(manifold, col - 1) + quantum_splits(manifold, col + 1)
  else
    return quantum_splits(manifold[1..], col)
  end
end

def solve_part_two_recursive(manifold)
  quantum_splits(manifold, manifold[0].index("S"))
end

def solve_part_two(manifold)
  start = manifold[0].index("S")
  paths = [
    Array.new(manifold[0].length) { |i| i == start ? 1 : 0 }
  ]
  previous_path_row = paths[0]
  manifold[1..].each.with_index do |row, row_i|
    path_row = Array.new(row.length) { 0 }
    row.each_char.with_index do |char, i|
      if char == "^"
        above = previous_path_row[i]
        left = path_row[i - 1]
        right = path_row[i + 1]
        path_row[i - 1] = above + left
        path_row[i + 1] = above + right
      else
        path_row[i] = previous_path_row[i] + path_row[i]
      end
    end
    paths << path_row
    previous_path_row = path_row
  end
  paths[-1].sum
end

manifold = File.readlines("input/d07").map(&:chomp)
if ARGV[0] == "2"
  puts solve_part_two(manifold)
else
  puts solve_part_one(manifold)
end
