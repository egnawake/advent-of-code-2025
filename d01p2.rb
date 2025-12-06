dial = 50
n = 100
count = 0

lines = File.readlines("./input/d01p1")
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

puts count
