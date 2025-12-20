# frozen_string_literal: true

# Day 7: Laboratories
module Day7
  def self.load_diagram(path)
    IO.readlines(path).map(&:strip)
  end

  # Part 1: Count tachyon manifold splits
  module Part1
    def self.render_tachyon_beam_row(row, prev_row)
      row.chars.map.with_index do |elem, elem_index|
        next elem unless elem == '.'
        next '|' if elem_index.positive? && row[elem_index - 1] == '^'
        next '|' if row[elem_index + 1] == '^'
        next '|' if prev_row[elem_index] == 'S'
        next '|' if prev_row[elem_index] == '|'

        next elem
      end.join
    end

    def self.render_tachyon_beams(diagram)
      prev_row = diagram[0]
      diagram.map.with_index do |row, row_index|
        next row if row_index.zero?

        rendered_row = render_tachyon_beam_row(row, prev_row)
        prev_row = rendered_row
        rendered_row
      end
    end

    def self.count_splits(diagram)
      beam_diagram = render_tachyon_beams diagram
      beam_diagram.map.with_index do |row, row_index|
        next 0 if row_index.zero?

        prev_row = beam_diagram[row_index - 1]
        row.chars.zip(prev_row.chars).select { |pair| pair == ['^', '|'] }.size
      end.sum
    end
  end

  # Part 2: Count tachyon manifold particle timelines
  module Part2
    def self.activated_splitter?(prev_row, row, elem_idx)
      elem_idx >= 0 && row[elem_idx] == '^' && prev_row[elem_idx].positive?
    end

    def self.count_row_timelines(prev_row, row)
      row.chars.map.with_index do |elem, elem_idx|
        next 0 if elem == '^'

        left_branch = activated_splitter?(prev_row, row, elem_idx + 1) ? prev_row[elem_idx + 1] : 0
        right_branch = activated_splitter?(prev_row, row, elem_idx - 1) ? prev_row[elem_idx - 1] : 0
        prev_row[elem_idx] + left_branch + right_branch
      end
    end

    def self.count_timelines(diagram)
      initial_row = diagram[0].chars.map { |e| e == 'S' ? 1 : 0 }
      diagram[1..].reduce(initial_row) { |prev_row, row| count_row_timelines(prev_row, row) }.sum
    end
  end
end

if __FILE__ == $PROGRAM_NAME
  puts 'Day 7: Laboratories'
  diagram = Day7.load_diagram './day7_input.txt'

  puts "Part 1: #{Day7::Part1.count_splits diagram}"
  puts "Part 2: #{Day7::Part2.count_timelines(diagram)}"
end
