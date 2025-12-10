# frozen_string_literal: true

# Advent of code day 2 module
module Day2
  def self.load_id_ranges(filename)
    IO.read(filename).strip.split(',').map { |id_range| id_range.split('-') }
  end

  def self.invalidid?(id)
    id[0, id.length / 2] == id[id.length / 2, id.length]
  end

  def self.invalid_ids_between(id_start, id_end)
    invalid_ids = 0

    # the next possible invalid id is the first half of the id repeated
    next_invalid_id_segment = id_start.length == 1 ? id_start : id_start[0, id_start.length / 2]
    loop do
      next_invalid_id = Integer(next_invalid_id_segment + next_invalid_id_segment)
      break if next_invalid_id >= Integer(id_end)

      # if the next valid id is actually after the starting id of the range
      invalid_ids += next_invalid_id > Integer(id_start) ? next_invalid_id : 0

      # find next possible invalid id by incrementing the id segment (eg. first part of the id)
      next_invalid_id_segment = String(Integer(next_invalid_id_segment) + 1)
    end

    invalid_ids
  end

  def self.part1(id_ranges)
    summed_ids = 0
    id_ranges.each do |id_range|
      summed_ids += Integer(id_range[0]) if invalidid? id_range[0]
      summed_ids += Integer(id_range[1]) if invalidid? id_range[1]
      summed_ids += invalid_ids_between(*id_range)
    end
    summed_ids
  end
end

if __FILE__ == $PROGRAM_NAME
  id_ranges = Day2.load_id_ranges './day2_input.txt'
  part1 = Day2.part1 id_ranges
  puts "Part 1: #{part1}"
end
