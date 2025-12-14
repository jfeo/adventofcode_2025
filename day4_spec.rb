# frozen_string_literal: true

require 'tempfile'
require 'rspec'
require_relative 'day4'

RSpec.describe Day4 do
  describe '#load_diagram' do
    it 'loads all ranges' do
      file = Tempfile.new
      IO.write(file.path, "..@.@\n@@@..")
      expect(Day4.load_diagram(file.path)).to eq(['..@.@', '@@@..'])
    ensure
      file.close
      file.unlink
    end
  end

  diagram = Day4.load_diagram 'day4_spec_input.txt'

  describe Day4::Part1 do
    describe '#run' do
      it 'returns expected value, given test data' do
        expect(Day4::Part1.run(diagram)).to eq(13)
      end
    end
  end

  describe Day4::Part2 do
    describe '#run' do
      it 'returns expected value, given test data' do
        expect(Day4::Part2.run(diagram)).to eq(43)
      end
    end
  end
end
