# frozen_string_literal: true

require 'tempfile'
require 'rspec'
require_relative 'day9'

example_floor_pattern_input = "7,1
11,1
11,7
9,7
9,5
2,5
2,3
7,3"
example_floor_pattern_file = Tempfile.new
IO.write(example_floor_pattern_file.path, example_floor_pattern_input)

RSpec.describe Day9 do
  describe '#load_floor_pattern' do
    it 'returns expected example floor pattern' do
      expected = [
        [7, 1],
        [11, 1],
        [11, 7],
        [9, 7],
        [9, 5],
        [2, 5],
        [2, 3],
        [7, 3]
      ]
      expect(Day9.load_floor_pattern(example_floor_pattern_file.path)).to eq(expected)
    end
  end

  describe '#rectangle_area' do
    it 'is commutative' do
      tile1 = [1, 2]
      tile2 = [11, 12]
      expect(Day9.rectangle_area([tile1, tile2])).to eq(Day9.rectangle_area([tile2, tile1]))
    end
  end

  example_floor_pattern = Day9.load_floor_pattern(example_floor_pattern_file.path)

  describe '#largest_rectangle_area_between_red_tiles' do
    it 'returns expected value given example input' do
      actual = Day9.largest_rectangle_area_between_red_tiles(example_floor_pattern)
      expect(actual).to eq(50)
    end

    it 'returns expected value given real input' do
      actual = Day9.largest_rectangle_area_between_red_tiles(Day9.load_floor_pattern('./day9_input.txt'))
      expected = 4_776_100_539
      expect(actual).to eq(expected)
    end
  end
end
