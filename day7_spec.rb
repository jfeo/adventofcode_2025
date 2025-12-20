# frozen_string_literal: true

require 'rspec'
require_relative 'day7'
require 'tempfile'

example_input = ".......S.......
...............
.......^.......
...............
......^.^......
...............
.....^.^.^.....
...............
....^.^...^....
...............
...^.^...^.^...
...............
..^...^.....^..
...............
.^.^.^.^.^...^.
..............."

example_input_beams_rendered = ".......S.......
.......|.......
......|^|......
......|.|......
.....|^|^|.....
.....|.|.|.....
....|^|^|^|....
....|.|.|.|....
...|^|^|||^|...
...|.|.|||.|...
..|^|^|||^|^|..
..|.|.|||.|.|..
.|^|||^||.||^|.
.|.|||.||.||.|.
|^|^|^|^|^|||^|
|.|.|.|.|.|||.|"

RSpec.describe Day7 do
  describe '#load_diagram' do
    it 'returns expected diagram' do
      file = Tempfile.new
      IO.write(file.path, "..S..\n.....\n..^..\n.....\n.^.^.\n.....")
      expected_diagram = [
        '..S..',
        '.....',
        '..^..',
        '.....',
        '.^.^.',
        '.....'
      ]
      actual_diagram = Day7.load_diagram file.path
      expect(actual_diagram).to eq(expected_diagram)
    end
  end

  example_input_file = Tempfile.new
  IO.write(example_input_file.path, example_input)
  diagram = Day7.load_diagram example_input_file.path

  describe Day7::Part1 do
    describe '#render_tachyon_beams' do
      it 'returns expected rendered beam diagram, given example input' do
        beam_diagram = Day7::Part1.render_tachyon_beams diagram
        expect(beam_diagram.join("\n")).to eq(example_input_beams_rendered)
      end
    end

    describe '#count_splits' do
      it 'returns expected number of splits, given example input' do
        actual_splits = Day7::Part1.count_splits diagram
        expect(actual_splits).to eq(21)
      end
    end
  end

  describe Day7::Part2 do
    describe '#count_timelines' do
      it 'counts single timeline' do
        straight_diagram = [
          '..S..',
          '.....',
          '.....',
          '.....',
          '.....'
        ]
        actual_count = Day7::Part2.count_timelines straight_diagram
        expect(actual_count).to eq(1)
      end

      it 'counts two-split timeline' do
        two_split_diagram = [
          '..S..',
          '.....',
          '..^..',
          '.....',
          '.^...',
          '.....'
        ]
        actual_count = Day7::Part2.count_timelines two_split_diagram
        expect(actual_count).to eq(3)
      end

      it 'returns expected count, given example input' do
        actual_count = Day7::Part2.count_timelines(diagram)
        expect(actual_count).to eq(40)
      end
    end
  end
end
