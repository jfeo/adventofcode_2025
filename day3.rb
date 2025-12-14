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
    def self.maximum_battery_bank_joltage(batteries)
      first_index = 0
      second_index = 1

      (1..(batteries.size - 2)).each do |battery_index|
        first_index = battery_index if batteries[battery_index] > batteries[first_index]
        if batteries[battery_index + 1] > batteries[second_index] || second_index <= first_index
          second_index = (battery_index + 1)
        end
      end

      batteries[first_index] * 10 + batteries[second_index]
    end

    def self.run(battery_banks)
      battery_banks.map { |batteries| maximum_battery_bank_joltage batteries }.sum
    end
  end

  # Part 2 - now find the maximum joltage by turning on exactly twelve batteries
  # each bank
  module Part2
    def self.turn_on_battery(batteries, on_indices, battery_index)
      on_indices.each_index do |j|
        joltage_higher = batteries[battery_index + j] > batteries[on_indices[j]]
        previous_digit_shifted = j.positive? && on_indices[j] <= on_indices[j - 1]
        on_indices[j] = battery_index + j if joltage_higher || previous_digit_shifted
      end
    end

    def self.maximum_battery_bank_joltage(batteries)
      on_indices = (0..11).to_a
      (1..batteries.size - 12).each { |i| turn_on_battery(batteries, on_indices, i) }
      on_indices.map.with_index { |battery_index, j| batteries[battery_index] * 10**(11 - j) }.sum
    end

    def self.run(battery_banks)
      battery_banks.map { |batteries| maximum_battery_bank_joltage batteries }.sum
    end
  end
end

if __FILE__ == $PROGRAM_NAME
  puts 'Day 3'
  battery_banks = Day3.load_battery_banks('./day3_input.txt')
  part1 = Day3::Part1.run battery_banks
  puts "Part 1: #{part1}"
  part2 = Day3::Part2.run battery_banks
  puts "Part 2: #{part2}"
end
