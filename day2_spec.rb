# frozen_string_literal: true

require 'rspec'
require_relative 'day2'

RSpec.describe Day2 do
  id_ranges = Day2.load_id_ranges 'day2_spec_input.txt'
  describe '#part1' do
    it 'returns the expected value' do
      expect(Day2.part1(id_ranges)).to eq(1_227_775_554)
    end
  end
end
