# frozen_string_literal: true

require 'tempfile'
require 'rspec'
require_relative 'day2'

RSpec.describe Day2 do
  describe '#load_id_ranges' do
    it 'loads all ranges' do
      file = Tempfile.new
      IO.write(file.path, '1-2,3-4,5-6')
      expect(Day2.load_id_ranges(file.path)).to eq([%w[1 2], %w[3 4], %w[5 6]])
    ensure
      file.close
      file.unlink
    end
  end

  id_ranges = Day2.load_id_ranges 'day2_spec_input.txt'

  describe Day2::Part1 do
    it 'returns the expected value' do
      expect(Day2::Part1.run(id_ranges)).to eq(1_227_775_554)
    end
  end

  describe Day2::Part2 do
    describe '#invalid_id?' do
      it 'returns true for invalid id' do
        expect(Day2::Part2.invalid_id?('11')).to eq(true)
        expect(Day2::Part2.invalid_id?('222')).to eq(true)
        expect(Day2::Part2.invalid_id?('2345678923456789')).to eq(true)
        expect(Day2::Part2.invalid_id?('123123123123123123123')).to eq(true)
        expect(Day2::Part2.invalid_id?('999999999999999')).to eq(true)
        expect(Day2::Part2.invalid_id?('432432')).to eq(true)
        expect(Day2::Part2.invalid_id?('44')).to eq(true)
        expect(Day2::Part2.invalid_id?('900900')).to eq(true)
      end

      it 'returns false for valid id' do
        %w[1 2 3 4 5 6 7 8 9 10 12 100 900901 123456789 83423442393243241].each do |valid_id|
          expect(Day2::Part2.invalid_id?(valid_id)).to eq(false)
        end
      end
    end

    describe '#run' do
      it 'returns zero given ranges with no invalid ids' do
        expect(Day2::Part2.run([%w[]])).to eq(0)
        expect(Day2::Part2.run([%w[0 9]])).to eq(0)
        expect(Day2::Part2.run([%w[0 10]])).to eq(0)
        expect(Day2::Part2.run([%w[12345678 12345679]])).to eq(0)
      end

      it 'gives the correct answer for the test data' do
        expect(Day2::Part2.run(id_ranges)).to eq(4_174_379_265)
      end

      it 'gives a higher result than any results that were too low from previous incorrect implementations' do
        expect(Day2::Part2.run(Day2.load_id_ranges('./day2_input.txt'))).to be > 31_898_924_720
      end

      it 'gives a lower result than any results that were too high from previous incorrect implementations' do
        expect(Day2::Part2.run(Day2.load_id_ranges('./day2_input.txt'))).to be < 31_898_925_905
      end
    end
  end
end
