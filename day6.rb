# frozen_string_literal: true

module Day6
  # Part 1 - solve worksheets as columns where each row is a number
  module Part1
    def self.parse_worksheet(raw_worksheet)
      raw_worksheet
        .split("\n")
        .map { |ln| ln.split(' ') }
        .transpose
        .map { |problem| [problem[-1], problem[..-2].map { |n| Integer(n) }] }
    end

    def self.load_worksheet(path)
      parse_worksheet(IO.read(path))
    end

    def self.solve_worksheet(worksheet)
      worksheet.map do |problem|
        operator, operands = problem
        if operator == '*'
          operands.reduce(1) { |r, v| r * v }
        elsif operator == '+'
          operands.reduce(0) { |r, v| r + v }
        else
          raise(StandardError, "invalid operator \"#{operator}\"")
        end
      end.sum
    end
  end

  # Part 2 - solve worksheets where numbers are stored column wise
  module Part2
    def self.reduce_worksheet_column(r, n)
      arr, cur = r
      if n.join.strip.empty?
        arr.push(cur)
        cur = []
      elsif n[-1] != ' '
        cur.push(Integer(n[..-2].join))
        cur.push(n[-1])
      else
        cur.push(Integer(n[..-2].join))
      end
      [arr, cur]
    end

    def self.parse_worksheet(raw_worksheet)
      a = raw_worksheet.split("\n").map(&:chars)
      m = a.map(&:size).max
      b = a.map { |r| r + [' '] * (m - r.size) }
      c, d = b.transpose.reverse.reduce([[], []]) { |r, n| reduce_worksheet_column(r, n) }
      c.push(d)
      c.map { |col| [col[-1], col[..-2]] }
    end

    def self.load_worksheet(path)
      parse_worksheet(IO.read(path))
    end

    def self.solve_worksheet(worksheet)
      worksheet.map do |problem|
        operator, operands = problem
        if operator == '*'
          operands.reduce(1) { |r, v| r * v }
        elsif operator == '+'
          operands.reduce(0) { |r, v| r + v }
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
