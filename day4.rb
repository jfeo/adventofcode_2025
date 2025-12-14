# frozen_string_literal: true

# Day 4
module Day4
  def self.load_diagram(filename)
    IO.readlines(filename).map(&:strip)
  end

  # Part 1
  module Part1
    def self.roll_accessible?(diagram, xpos, ypos)
      xmin = [xpos - 1, 0].max
      xmax = [xpos + 1, diagram[0].size - 1].min
      ymin = [ypos - 1, 0].max
      ymax = [ypos + 1, diagram.size - 1].min

      (ymin..ymax).map do |y|
        (xmin..xmax).map { |x| diagram[y][x] == '@' ? 1 : 0 }.sum
      end.sum - 1 < 4
    end

    def self.run(diagram)
      diagram.map.with_index do |row, y|
        row.chars.map.with_index do |cell, x|
          next 0 unless cell == '@'
          next 0 unless roll_accessible?(diagram, x, y)

          1
        end.sum
      end.sum
    end
  end
end

if __FILE__ == $PROGRAM_NAME
  puts 'Day 4'
  diagram = Day4.load_diagram('./day4_input.txt')
  part1 = Day4::Part1.run diagram
  puts "Part 1: #{part1}"
end
