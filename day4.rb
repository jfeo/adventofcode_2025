# frozen_string_literal: true

# Day 4
module Day4
  def self.load_diagram(filename)
    IO.readlines(filename).map(&:strip)
  end

  # Part 1 - count number of accessible paper rolls
  module Part1
    def self.surrounding_positions(diagram, xpos, ypos)
      xmin = [xpos - 1, 0].max
      xmax = [xpos + 1, diagram[0].size - 1].min
      ymin = [ypos - 1, 0].max
      ymax = [ypos + 1, diagram.size - 1].min
      [xmin, xmax, ymin, ymax]
    end

    def self.roll_accessible?(diagram, xpos, ypos)
      xmin, xmax, ymin, ymax = surrounding_positions(diagram, xpos, ypos)
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

  # Part 2 - iteratively remove paper rolls from the diagram while keeping a tally
  # of the number of removed paper rolls
  module Part2
    def self.remove_accessible_paper_rolls(diagram)
      removed = diagram.map.with_index do |row, y|
        row.chars.map.with_index do |cell, x|
          next 0 unless cell == '@'
          next 0 unless Day4::Part1.roll_accessible?(diagram, x, y)

          diagram[y][x] = '.'

          1
        end.sum
      end.sum

      [diagram, removed]
    end

    def self.remove_all_paper_rolls(diagram)
      total_removed = 0

      loop do
        diagram, removed = remove_accessible_paper_rolls diagram
        break if removed.zero?

        total_removed += removed
      end

      total_removed
    end

    def self.run(diagram)
      remove_all_paper_rolls(diagram)
    end
  end
end

if __FILE__ == $PROGRAM_NAME
  puts 'Day 4'
  diagram = Day4.load_diagram('./day4_input.txt')
  part1 = Day4::Part1.run diagram
  puts "Part 1: #{part1}"
  part2 = Day4::Part2.run diagram
  puts "Part 2: #{part2}"
end
