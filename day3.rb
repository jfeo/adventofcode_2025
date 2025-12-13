# frozen_string_literal: true

# Day 3
module Day3
  # Read the lines a battery bank input data file, and map each line to an array of integers representing each battery's
  # joltage
  def self.load_battery_banks(filename)
    IO.readlines(filename).map do |ln|
      ln.strip.chars.map { |digit| Integer(digit) }
    end
  end

  # Part 1 - find the two batteries in each battery bank that maximise battery
  # bank joltage, and sum the joltages of all battery banks.
  module Part1
    def self.maximum_battery_bank_joltage(battery_bank)
      first_index = 0
      second_index = 1

      (1..(battery_bank.size - 2)).each do |i|
        first_index = i if battery_bank[i] > battery_bank[first_index]
        second_index = (i + 1) if battery_bank[i + 1] > battery_bank[second_index] || second_index <= first_index
      end

      battery_bank[first_index] * 10 + battery_bank[second_index]
    end

    def self.run(battery_banks)
      battery_banks.map { |bank| maximum_battery_bank_joltage bank }.sum
    end
  end
end

if __FILE__ == $PROGRAM_NAME
  puts 'Day 3'
  battery_banks = Day3.load_battery_banks('./day3_input.txt')
  part1 = Day3::Part1.run battery_banks
  puts "Part 1: #{part1}"
end
