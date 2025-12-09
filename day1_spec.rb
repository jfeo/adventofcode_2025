# frozen_string_literal: true

require 'rspec'
require_relative 'day1'

RSpec.describe Day1 do
  instructions = Day1.load_instructions 'day1_spec_input.txt'
  describe '#part1' do
    it 'returns the expected value' do
      expect(Day1.part1(instructions)).to eq(3)
    end
  end

  describe '#part2' do
    it 'returns the expected value' do
      expect(Day1.part2(instructions)).to eq(6)
    end
  end
end
