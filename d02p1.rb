def parse_ranges(text)
  range_strings = text.split(",")
  range_arrays = range_strings.map {|s| s.split("-")}
  range_arrays_as_ints = range_arrays.map {|arr| arr.map {|n| Integer(n)}}

  range_arrays_as_ints
end

def is_valid_id(id)
  id_str = String(id)
  if id_str.length % 2 > 0 then
    false
  else
    half_length = id_str.length.div(2)
    id_str[..half_length - 1] == id_str[half_length..]
  end
end

def are_groups_equal(str, n_groups)
  result = true
  n_digits = str.length.div(n_groups)
  group = str[0..n_digits - 1]
  i = 1
  while i < n_groups do
    result = result && str[i * n_digits..i * n_digits + n_digits - 1] == group
    i = i + 1
  end

  result
end

def is_valid_id_part_two(id)
  id_str = String(id)
  d = 2
  while d <= id_str.length do
    if id_str.length % d == 0 && are_groups_equal(id_str, d) then
      return true
    end
    d = d + 1
  end

  false
end

text = File.read("./input/d02p1")
ranges = parse_ranges(text)

sum = 0

ranges.each do |r|
  id = r[0]
  while id <= r[1] do
    if is_valid_id_part_two(id) then
      sum = sum + id
    end
    id = id + 1
  end
end

puts sum
