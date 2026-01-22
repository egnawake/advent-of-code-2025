require_relative "cli"

class Day11Solver
  def initialize(input_stream)
    @input_stream = input_stream
  end

  def parse_connections
    connections = Hash.new

    @input_stream.each(chomp: true) do |line|
      device_match = line.match(/^(\w+): /)
      device = device_match[1]
      outputs = device_match.post_match.split(" ")
      connections[device] = outputs
    end

    connections
  end

  def path_count(connections, from, to)
    if connections[from].include?(to)
      1
    else
      connections[from].map do |out|
        path_count(connections, out, to)
      end.sum
    end
  end

  def paths_through_dac_fft(connections, from, to, passes_dac, passes_fft, cache)
    key = [from, passes_dac, passes_fft]
    if cache.has_key?(key)
      cache[key]
    elsif connections[from].include?(to)
      passes_dac && passes_fft ? 1 : 0
    else
      path_count = connections[from].map do |out|
        paths_through_dac_fft(connections, out, to,
          passes_dac || out == "dac",
          passes_fft || out == "fft",
          cache
        )
      end.sum
      cache[key] += path_count
      path_count
    end
  end

  def part_one
    connections = parse_connections
    path_count(connections, "you", "out")
  end

  def part_two
    connections = parse_connections
    paths_through_dac_fft(connections, "svr", "out", false, false, Hash.new(0))
  end
end

CLI.new(Day11Solver).start
