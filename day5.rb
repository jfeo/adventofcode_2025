# frozen_string_literal: true

# Day 5: Cafeteria
module Day5
  def self.load_ingredient_database(filename)
    fresh_id_ranges = []
    available_ids = []

    reading_available_ids = false
    (IO.readlines filename).each do |ln|
      next available_ids.push(Integer(ln.strip)) if reading_available_ids
      next reading_available_ids = true if ln == "\n"

      id_begin, id_end = ln.strip.split('-').map { |x| Integer(x) }
      fresh_id_ranges.push(id_begin..id_end)
    end

    [fresh_id_ranges, available_ids]
  end

  # Part 1: How many available ingredients are fresh?
  module Part1
    # Index of ingredients that indexes the fresh/spoiled state of ingredient identified by IDs
    class IngredientIndex
      def find_existing_merged_id_range(range)
        @merged_fresh_id_ranges.index do |merged_range|
          (merged_range.include? range.begin) || (merged_range.include? range.end)
        end
      end

      def initialize(fresh_id_ranges)
        @merged_fresh_id_ranges = []
        fresh_id_ranges.each do |range|
          existing_merged_range_index = find_existing_merged_id_range(range)
          next @merged_fresh_id_ranges.push(range) if existing_merged_range_index.nil?

          merged_range = @merged_fresh_id_ranges[existing_merged_range_index]
          merged_range = [range.begin, merged_range.begin].min..[range.end, merged_range.end].max
          @merged_fresh_id_ranges[existing_merged_range_index] = merged_range
        end
      end

      def fresh?(ingredient_id)
        @merged_fresh_id_ranges.any? { |range| range.include? ingredient_id }
      end
    end

    def self.run(ingredient_db)
      fresh_id_ranges, available_ids = ingredient_db
      ingredient_index = IngredientIndex.new(fresh_id_ranges)
      available_ids.filter { |ingredient_id| ingredient_index.fresh?(ingredient_id) }.size
    end
  end
end

if __FILE__ == $PROGRAM_NAME
  puts 'Day 5: Cafeteria'
  ingredient_db = Day5.load_ingredient_database('./day5_input.txt')
  puts "Part 1: #{Day5::Part1.run ingredient_db}"
end
