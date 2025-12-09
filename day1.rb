# frozen_string_literal: true

# Advent of code day 1 module
module Day1
  def self.load_instructions(filename)
    (IO.readlines filename).map do |ln|
      [ln[0], Integer(ln[1..])]
    end
  end

  def self.turndial(dial, instruction)
    rotations = instruction[1] / 100
    number = instruction[1] % 100
    number = instruction[0] == 'R' ? number : -number
    if dial != 0
      rotations += dial + number > 100 ? 1 : 0
      rotations += (dial + number).negative? ? 1 : 0
    end
    dial += number
    dial += (dial.negative? ? 100 : 0) - (dial > 99 ? 100 : 0)
    [dial, rotations]
  end

  def self.part1(instructions)
    password = 0
    dial = 50
    instructions.map do |instruction|
      dial, = turndial(dial, instruction)
      password += dial.zero? ? 1 : 0
    end
    password
  end

  def self.part2(instructions)
    password = 0
    dial = 50
    instructions.map do |instruction|
      dial, rotations = turndial(dial, instruction)
      password += dial.zero? ? 1 : 0
      password += rotations
    end
    password
  end

  def self.main
    instructions = load_instructions './day1_input.txt'
    pw1 = part1 instructions
    puts "Part 1 password: #{pw1}"
    pw2 = part2 instructions
    puts "Part 2 password: #{pw2}"
  end
end

Day1.main if __FILE__ == $PROGRAM_NAME
