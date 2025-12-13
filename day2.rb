# frozen_string_literal: true

# Advent of code day 2 module
module Day2
  def self.load_id_ranges(filename)
    IO.read(filename).strip.split(',').map { |id_range| id_range.split('-') }
  end

  # Part 1
  module Part1
    def self.invalid_id?(id)
      id[0, id.length / 2] == id[id.length / 2, id.length]
    end

    def self.sum_invalid_ids_between(id_start, id_end)
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

    def self.run(id_ranges)
      summed_ids = 0
      id_ranges.each do |id_range|
        summed_ids += Integer(id_range[0]) if invalid_id? id_range[0]
        summed_ids += Integer(id_range[1]) if invalid_id? id_range[1]
        summed_ids += sum_invalid_ids_between(*id_range)
      end
      summed_ids
    end
  end

  # Part 2
  module Part2
    def self.invalid_id?(invalid_id)
      return false if invalid_id.size == 1

      (1..invalid_id.size / 2).map do |segsize|
        next false unless (invalid_id.size % segsize).zero?

        seg = invalid_id[0, segsize]
        segcount = invalid_id.size / segsize
        invalid_id == seg * segcount
      end.any?
    end

    # Helper class to easily generate all invalid IDs for a given segment, of a certain length
    class InvalidIdGenerator
      def initialize(id_start, id_end, idsize, segsize)
        @id_start = id_start
        @id_end = id_end
        @segcount = idsize / segsize # how many segments can fit into id of this size
        @segnext = compute_initial_segnext(segsize, idsize, id_start)
        @seglast = idsize < id_end.size ? "9#{'9' * (segsize - 1)}" : id_end[0, segsize]
      end

      def compute_initial_segnext(segsize, idsize, id_start)
        segnext = idsize > id_start.size ? "1#{'0' * (segsize - 1)}" : id_start[0, segsize]
        Integer(segnext * @segcount) < Integer(id_start) ? (Integer(segnext) + 1).to_s : segnext
      end

      def next?
        @segnext <= @seglast and Integer(@segnext * @segcount) <= Integer(@id_end)
      end

      def next
        return nil unless next?

        result = Integer(@segnext * @segcount)
        @segnext = (Integer(@segnext) + 1).to_s

        unless Part2.invalid_id?(result.to_s)
          puts "Valid ID was somehow generated #{result} (#{@segcount}) (#{@id_start}-#{@id_end})"
        end

        result
      end
    end

    def self.invalid_id_generators(id_start, id_end)
      generators = []

      (1..id_end.size / 2).each do |segsize|
        (id_start.size..id_end.size).each do |idsize|
          next unless idsize > 1 and (idsize % segsize).zero?

          g = InvalidIdGenerator.new(id_start, id_end, idsize, segsize)
          generators.push(g)
        end
      end

      generators
    end

    def self.find_invalid_ids_in_range(id_start, id_end)
      result = Set[]
      invalid_id_generators(id_start, id_end).map do |gen|
        result.add(gen.next) while gen.next?
      end
      result
    end

    def self.run(id_ranges)
      id_ranges.map do |range|
        find_invalid_ids_in_range(range[0], range[1]).map { |id| Integer(id) }.sum
      end.sum
    end
  end
end

if __FILE__ == $PROGRAM_NAME
  puts 'Day 2'
  id_ranges = Day2.load_id_ranges './day2_input.txt'
  part1 = Day2::Part1.run id_ranges
  puts "Part 1: #{part1}"

  part2 = Day2::Part2.run id_ranges
  puts "Part 2: #{part2}"
end
