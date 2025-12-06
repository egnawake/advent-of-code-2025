dial = 50
n = 100
count = 0

lines = File.readlines("./input/d01p1")
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

puts count
