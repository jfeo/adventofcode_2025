# frozen_string_literal: true

module Day6
  # Part 1 - solve worksheets as columns where each row is a number
  module Part1
    def self.parse_worksheet(raw_worksheet)
      raw_worksheet
        .split("\n")
        .map { |ln| ln.split(' ') }
        .transpose
        .map { |problem| [problem[-1], problem[..-2].map { |col| Integer(col) }] }
    end

    def self.load_worksheet(path)
      parse_worksheet(IO.read(path))
    end

    def self.solve_worksheet(worksheet)
      worksheet.map do |problem|
        operator, operands = problem
        if operator == '*'
          operands.reduce(1) { |agg, v| agg * v }
        elsif operator == '+'
          operands.reduce(0) { |agg, v| agg + v }
        else
          raise(StandardError, "invalid operator \"#{operator}\"")
        end
      end.sum
    end
  end

  # Part 2 - solve worksheets where numbers are stored column wise
  module Part2
    def self.reduce_worksheet_column(agg, col)
      arr, operands = agg
      return [arr, operands] if col.join.strip.empty?

      operands.push(Integer(col[..-2].join))

      operator = col[-1]
      if operator != ' '
        arr.push([operator, operands])
        [arr, []]
      else
        [arr, operands]
      end
    end

    def self.parse_worksheet(raw_worksheet)
      split_ws = raw_worksheet.split("\n").map(&:chars)
      max_row_size = split_ws.map(&:size).max
      split_balanced_ws = split_ws.map { |agg| agg + [' '] * (max_row_size - agg.size) }
      transposed_ws = split_balanced_ws.transpose.reverse
      transposed_ws.push([]) # add empty line to make reducer reduce the last line
      transposed_ws.reduce([[], []]) { |agg, col| reduce_worksheet_column(agg, col) }[0]
    end

    def self.load_worksheet(path)
      parse_worksheet(IO.read(path))
    end

    def self.solve_worksheet(worksheet)
      worksheet.map do |problem|
        operator, operands = problem
        if operator == '*'
          operands.reduce(1) { |agg, v| agg * v }
        elsif operator == '+'
          operands.reduce(0) { |agg, v| agg + v }
        else
          raise(StandardError, "invalid operator \"#{operator}\"")
        end
      end.sum
    end
  end
end

if __FILE__ == $PROGRAM_NAME
  puts 'Day 6'
  puts "Part 1: #{Day6::Part1.solve_worksheet(Day6::Part1.load_worksheet('./day6_input.txt'))}"
  puts "Part 2: #{Day6::Part2.solve_worksheet(Day6::Part2.load_worksheet('./day6_input.txt'))}"
end
