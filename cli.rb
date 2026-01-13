class CLI
  def initialize(solver_class)
    @solver_class = solver_class
  end

  def start
    part = parse!(ARGV, "part") { Integer(_1) }

    if ARGV.empty?
      exit 1, "Argument error: input file"
    end

    case part
    when 1
      solver = @solver_class.new(ARGF)
      puts solver.part_one
    when 2
      solver = @solver_class.new(ARGF)
      puts solver.part_two
    else
      exit 1, "Argument error: unrecognized part"
    end
  end

  private def parse!(args, err_msg, &parser)
    arg = args.shift
    parser.call(arg)
  rescue
    exit 1, "Argument error: #{err_msg}"
  end

  private def exit(status, message="Error: status #{status}")
    $stderr.puts message
    super status
  end
end
