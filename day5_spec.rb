# frozen_string_literal: true

require 'tempfile'
require 'rspec'
require_relative 'day5'

RSpec.describe Day5 do
  describe '#load_ingredient_database' do
    it 'loads expected data' do
      file = Tempfile.new
      IO.write(file.path, "1-2\n4-5\n\n1\n2\n3\n5\n6")
      fresh_id_ranges, available_ids = Day5.load_ingredient_database file.path
      expect(fresh_id_ranges).to eq([1..2, 4..5])
      expect(available_ids).to eq([1, 2, 3, 5, 6])
    end
  end

  ingredient_db = Day5.load_ingredient_database './day5_spec_input.txt'

  describe Day5::Part1 do
    describe '#run' do
      it 'returns expected number of fresh available ingredients, given test input' do
        fresh_available_ingredients_count = Day5::Part1.run(ingredient_db)
        expect(fresh_available_ingredients_count).to eq(3)
      end
    end
  end
end
