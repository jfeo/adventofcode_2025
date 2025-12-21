# frozen_string_literal: true

require 'tempfile'
require 'rspec'
require_relative 'day8'

example_input = "162,817,812
57,618,57
906,360,560
592,479,940
352,342,300
466,668,158
542,29,236
431,825,988
739,650,466
52,470,668
216,146,977
819,987,18
117,168,530
805,96,715
346,949,466
970,615,88
941,993,340
862,61,35
984,92,344
425,690,689"

example_input_file = Tempfile.new
IO.write(example_input_file.path, example_input)
example_junction_boxes = Day8.load_junction_boxes(example_input_file.path)

JunctionBox = Day8::JunctionBox

RSpec.describe JunctionBox do
  describe '#dist' do
    it 'returns 0 for same junction box' do
      jb = JunctionBox.new([1, 2, 3])
      expect(jb.dist(jb)).to eq(0)
    end

    it 'returns expected distance along axis' do
      a = JunctionBox.new([100, 0, 100])
      b = JunctionBox.new([200, 0, 100])
      expect(a.dist(b)).to eq(100)
    end

    it 'returns expected diagonal distance' do
      a = JunctionBox.new([100, 0, 100])
      b = JunctionBox.new([200, 0, 200])
      expect(a.dist(b)).to eq(Math.sqrt(2) * 100)
    end
  end
end

RSpec.describe Day8 do
  describe '#load_junction_boxes' do
    it 'returns expected parsed junction boxes' do
      f = Tempfile.new
      IO.write(f.path, "1,2,3\n456,789,101112")
      expected = [
        Day8::JunctionBox.new([1, 2, 3]),
        Day8::JunctionBox.new([456, 789, 101_112])
      ]
      expect(Day8.load_junction_boxes(f.path)).to eq(expected)
    end
  end
end

RSpec.describe Day8::Part1 do
  describe '#pairs' do
    it 'returns all unique unordered pairs' do
      expect(Day8::Part1.pairs([1, 2, 3])).to eq([[1, 2], [1, 3], [2, 3]])
    end
  end

  describe '#connect_k_closest' do
    it 'returns expected given example input' do
      circuits = Day8::Part1.connect_k_closest(example_junction_boxes, 10)
      expect(circuits.map(&:size).sort { |a, b| b <=> a }[..2]).to eq([5, 4, 2])
    end
  end
end
