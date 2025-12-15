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

  describe Day5::IngredientIndex do
    describe '#count_fresh_ingredients' do
      def count_fresh_ingredients(ranges)
        Day5::IngredientIndex.new(ranges).count_fresh_ingredients
      end
      it 'returns expected value for non-overlapping ranges' do
        expect(count_fresh_ingredients([1..10, 20..29])).to eq(20)
        expect(count_fresh_ingredients([1001..1005, 1..10, 300..300, 5000..5049])).to eq(5 + 10 + 1 + 50)
      end
      it 'returns expected value for overlapping ranges' do
        expect(count_fresh_ingredients([1..10, 1..10])).to eq(10)
        expect(count_fresh_ingredients([5..19, 11..15])).to eq(15)
        expect(count_fresh_ingredients([11..15, 5..19])).to eq(15)
        expect(count_fresh_ingredients([1_000_000..1_000_004, 900_000..2_000_000])).to eq(1_100_001)
        expect(count_fresh_ingredients([5..15, 11..20, 25..29, 1..10, 3..5, 18..25, 2..2, 0..1])).to eq(30)
      end
    end
  end

  describe Day5::Part2 do
    describe '#run' do
      it 'returns expected total number of fresh ingredient IDs, given test input' do
        total_fresh_ingredients_count = Day5::Part2.run(ingredient_db)
        expect(total_fresh_ingredients_count).to eq(14)
      end

      it 'returns a number lower than previous guesses that were too high' do
        total_fresh_ingredients_count = Day5::Part2.run(Day5.load_ingredient_database('./day5_input.txt'))
        expect(total_fresh_ingredients_count).to be < 345_486_116_638_844
      end
    end
  end
end
