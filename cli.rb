module CLI
  def self.run(solver_class)
    if ARGV.empty?
      $stderr.puts "Argument error: no arguments"
      exit 1
    end

    part = ARGV.shift

    if ARGV.empty?
      $stderr.puts "Argument error: no files to read"
      exit 1
    end

    case part
    when "1"
      solver = solver_class.new(ARGF)
      puts solver.part_one
    when "2"
      solver = solver_class.new(ARGF)
      puts solver.part_two
    else
      $stderr.puts "Argument error: unrecognized part"
      exit 1
    end
  end
end
