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

  # Index of ingredients that indexes the fresh/spoiled state of ingredient identified by IDs
  class IngredientIndex
    def find_overlapping_indexed_ranges(range)
      @index_id_ranges.filter_map.with_index do |merged_range, index|
        [merged_range, index] if range.overlap? merged_range
      end
    end

    def merge_ranges(range, overlapping_ranges)
      merged_range_begin = [range.begin, *overlapping_ranges.map { |r| r[0].begin }].min
      merged_range_end = [range.end, *overlapping_ranges.map { |r| r[0].end }].max
      merged_range_begin..merged_range_end
    end

    def initialize(fresh_id_ranges)
      @index_id_ranges = []
      fresh_id_ranges.each do |range|
        overlapping_ranges = find_overlapping_indexed_ranges(range)
        next @index_id_ranges.push(range) if overlapping_ranges.empty?

        merged_range_index = overlapping_ranges[0][1] # use the first overlapping range's index
        @index_id_ranges[merged_range_index] = merge_ranges(range, overlapping_ranges)

        # discard other overlapping ranges that have been replaced by the merged range
        # we assume that `overlapping_ranges` are ordered by increasing index
        overlapping_ranges[1..].reverse_each { |_, index| @index_id_ranges.delete_at(index) }
      end
    end

    def fresh?(ingredient_id)
      @index_id_ranges.any? { |range| range.include? ingredient_id }
    end

    def count_fresh_ingredients
      @index_id_ranges.map(&:size).sum
    end
  end

  # Part 1: How many available ingredients are fresh?
  module Part1
    def self.run(ingredient_db)
      fresh_id_ranges, available_ids = ingredient_db
      ingredient_index = Day5::IngredientIndex.new(fresh_id_ranges)
      available_ids.filter { |ingredient_id| ingredient_index.fresh?(ingredient_id) }.size
    end
  end

  # Part 2: How many possible fresh ingredients are there?
  module Part2
    def self.run(ingredient_db)
      fresh_id_ranges, = ingredient_db
      ingredient_index = Day5::IngredientIndex.new(fresh_id_ranges)
      ingredient_index.count_fresh_ingredients
    end
  end
end

if __FILE__ == $PROGRAM_NAME
  puts 'Day 5: Cafeteria'
  ingredient_db = Day5.load_ingredient_database('./day5_input.txt')
  puts "Part 1: #{Day5::Part1.run ingredient_db}"
  puts "Part 2: #{Day5::Part2.run ingredient_db}"
end
