def solve_part_one
  dial = 50
  n = 100
  count = 0

  lines = File.readlines("./input/d01")
  lines.each do |line|
    op = line[0]
    value = Integer(line[1..])
    if op == "L" then
      dial = (dial - value) % n
    elsif op == "R" then
      dial = (dial + value) % n
    end
    if dial == 0 then
      count = count + 1
    end
  end

  count
end

def solve_part_two
  dial = 50
  n = 100
  count = 0

  lines = File.readlines("./input/d01")
  lines.each do |line|
    op = line[0]
    value = Integer(line[1..])
    start = dial
    case op
      when "L" then dial = (dial - value)
      when "R" then dial = (dial + value)
    end
    if start != 0 && dial <= 0 then
      count = count + 1
    end
    count = count + dial.abs().div(n)
    dial = dial % n
  end

  count
end

if ARGV[0] == "2"
  puts solve_part_two
else
  puts solve_part_one
end
