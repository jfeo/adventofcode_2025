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
  describe '#part1' do
    it 'returns the expected value' do
      expect(Day2.part1(id_ranges)).to eq(1_227_775_554)
    end
  end
end
