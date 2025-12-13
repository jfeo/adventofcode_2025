# frozen_string_literal: true

require 'tempfile'
require 'rspec'
require_relative 'day3'

RSpec.describe Day3 do
  describe '#load_battery_banks' do
    it 'loads all ranges' do
      file = Tempfile.new
      IO.write(file.path, "12345\n67890")
      expect(Day3.load_battery_banks(file.path)).to eq([[1, 2, 3, 4, 5], [6, 7, 8, 9, 0]])
    ensure
      file.close
      file.unlink
    end
  end

  battery_banks = Day3.load_battery_banks 'day3_spec_input.txt'

  describe Day3::Part1 do
    describe '#run' do
      it 'returns expected value, given test data' do
        expect(Day3::Part1.run(battery_banks)).to eq(357)
      end
    end
  end

  describe Day3::Part2 do
    describe '#run' do
      it 'returns expected value, given test data' do
        expect(Day3::Part2.run(battery_banks)).to eq(3_121_910_778_619)
      end
    end
  end
end
