require "set"
require_relative "cli"

Machine = Struct.new(:target, :buttons)

class Day10Solver
  def initialize(input_stream)
    @input_stream = input_stream
  end

  def parse_machines
    @input_stream.readlines.map do |line|
      lights_match = line.match(/\[([.#]+)\]/)
      target = lights_match[1].each_char.with_index
        .filter { |c, i| c == "#" }
        .map { |c, i| i }
      target = Set.new(target)

      buttons = line.scan(/\((?:\d+,?)+\)/).map do |b|
        b.delete("()").split(",").map { Integer(_1) }
      end.map { |b| Set.new(b) }

      Machine.new(target, buttons)
    end
  end

  def toggle_lights(state, button)
    state ^ button
  end

  def find_least_presses(machine)
    states = [Set[]]
    presses = 0
    until states.include?(machine.target)
      raise "Too many presses" if presses >= 100

      presses += 1
      new_states = []
      states.each do |state|
        machine.buttons.each do |b|
          new_states << toggle_lights(state, b)
        end
      end
      states = new_states
    end

    presses
  end

  def part_one
    machines = parse_machines

    machines.map do |m|
      find_least_presses(m)
    end.sum
  end
end

CLI.new(Day10Solver).start
