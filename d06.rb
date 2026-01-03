def solve_part_one
  operations = File.readlines("input/d06")
    .map { _1.split(/\s+/) }
    .transpose

  operations.map do |op|
    *operands, operator = op
    operands.map { Integer(_1) }.reduce(operator.to_sym)
  end.reduce(:+)
end

class Array
  def split
    result = []
    slice = []
    self.each do |e|
      if yield(e)
        result << slice
        slice = []
      else
        slice << e
      end
    end
    result << slice
    result
  end
end

def solve_part_two
  *operand_lines, operator_line = File.readlines("input/d06")
    .map(&:chomp)
    .map(&:reverse) # problems are read right-to-left

  operands = operand_lines
    .map(&:chars)
    .transpose
    .map { |cs| cs.reject { |c| c == " " } }
    .map { |cs| cs.join }
    # split on strings that only had spaces (empty columns)
    .split { |e| e == "" }
    .map { |ops| ops.map { |op| Integer(op) } }

  operators = operator_line.strip.split(/\s+/)

  operations = operands.zip(operators)

  operations.map do |o|
    o[0].reduce(o[1].to_sym)
  end.reduce(:+)
end

if ARGV[0] == "2"
  puts solve_part_two
else
  puts solve_part_one
end
