# frozen_string_literal: true

require 'rspec'
require_relative 'day6'

example_data = "123 328  51 64
 45 64  387 23
  6 98  215 314
*   +   *   +  "

RSpec.describe Day6::Part1 do
  example_worksheet = Day6::Part1.parse_worksheet example_data
  describe '#parse_worksheet' do
    it 'parses worksheet' do
      expected_worksheet = [
        ['*', [123, 45, 6]],
        ['+', [328, 64, 98]],
        ['*', [51, 387, 215]],
        ['+', [64, 23, 314]]
      ]
      expect(example_worksheet).to eq(expected_worksheet)
    end
  end
  describe '#solve_worksheet' do
    it 'solves the example worksheet' do
      grand_total = Day6::Part1.solve_worksheet(example_worksheet)
      expect(grand_total).to eq(4_277_556)
    end
  end
end

RSpec.describe Day6::Part2 do
  example_worksheet = Day6::Part2.parse_worksheet example_data
  describe '#parse_worksheet' do
    it 'parses worksheet' do
      expected_worksheet = [
        ['+', [4, 431, 623]],
        ['*', [175, 581, 32]],
        ['+', [8, 248, 369]],
        ['*', [356, 24, 1]]
      ]
      expect(example_worksheet).to eq(expected_worksheet)
    end
  end
  describe '#solve_worksheet' do
    it 'solves the example worksheet' do
      grand_total = Day6::Part2.solve_worksheet(example_worksheet)
      expect(grand_total).to eq(3_263_827)
    end
  end
end
