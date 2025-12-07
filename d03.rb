$debug = false

def log(str)
  if $debug then
    puts str
  end
end

def index_of_largest(arr, from, to)
  largest_i = from
  largest = arr[largest_i]
  i = largest_i
  while i < arr.length && i < to do
    if arr[i] > largest then
      largest_i = i
      largest = arr[i]
    end
    i = i + 1
  end

  largest_i
end

def find_bank_joltage(bank)
  first = index_of_largest(bank, 0, bank.length - 1)
  log("Index of first: #{first}")
  second = index_of_largest(bank, first + 1, bank.length)
  log("Index of second: #{second}")

  joltage_str = bank[first] << bank[second]

  Integer(joltage_str)
end

def find_bank_joltage_part_two(bank)
  joltage_str = ""
  start = 0

  12.times do |i|
    j = index_of_largest(bank, start, bank.length - (12 - 1 - i))
    start = j + 1
    joltage_str << bank[j]
  end

  Integer(joltage_str)
end

lines = File.readlines("./input/d03").map {|l| l.chomp()}

sum = 0

lines.each do |line|
  log(line)
  bank = line.chars()
  joltage = find_bank_joltage_part_two(bank)
  log("Joltage: #{joltage}")
  sum = sum + joltage
end

puts sum
