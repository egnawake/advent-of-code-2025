$offsets = [
  [-1, 0],
  [-1, 1],
  [0, 1],
  [1, 1],
  [1, 0],
  [1, -1],
  [0, -1],
  [-1, -1],
]

def is_position_valid(grid, row, col)
  row >= 0 && row < grid.length && col >= 0 && col < grid[0].length
end

def count_adjacent_rolls(grid, row, col)
  adjacent_rolls = 0

  $offsets.each do |offset|
    other_row = row + offset[0]
    other_col = col + offset[1]
    if is_position_valid(grid, other_row, other_col)
      other_space = grid[other_row][other_col]
      adjacent_rolls += 1 if other_space == "@"
    end
  end

  adjacent_rolls
end

def solve_part_one(grid)
  accessible_rolls = 0

  grid.each_index do |row|
    grid[row].each_index do |col|
      if grid[row][col] == "@"
        adjacent_rolls = count_adjacent_rolls(grid, row, col)
        accessible_rolls += 1 if adjacent_rolls < 4
      end
    end
  end

  accessible_rolls
end

def solve_part_two(grid)
  total = 0
  accessible_rolls = 1

  while accessible_rolls > 0
    accessible_rolls = 0

    grid.each_index do |row|
      grid[row].each_index do |col|
        if grid[row][col] == "@"
          adjacent_rolls = count_adjacent_rolls(grid, row, col)
          if adjacent_rolls < 4
            accessible_rolls += 1
            grid[row][col] = "."
          end
        end
      end
    end
    total += accessible_rolls
  end

  total
end


grid = File.readlines("./input/d04").map {|l| l.chomp()}
grid = grid.map {|l| l.chars}

answer = if ARGV[0] == "2"
  solve_part_two(grid)
else
  solve_part_one(grid)
end

puts answer
