# frozen_string_literal: true

# Day 8: Playground
module Day8
  # Represents a junction box, that can compute its distance to other boxes
  class JunctionBox
    attr_reader :x, :y, :z

    def initialize(pos)
      @x, @y, @z = pos
    end

    def dist(other)
      Math.sqrt((@x - other.x)**2 + (@y - other.y)**2 + (@z - other.z)**2)
    end

    def ==(other)
      @x == other.x && \
        @y == other.y && \
        @z == other.z
    end

    alias eql? ==

    def self.from_s(str)
      JunctionBox.new(str.split(',').map { |e| Integer(e) })
    end

    def to_s
      "JBox(X=#{@x}, Y=#{y}, Z=#{z})"
    end
  end

  def self.load_junction_boxes(path)
    IO.readlines(path).map { |ln| JunctionBox.from_s(ln) }
  end

  # Part 1: Find circuits after connect k closest pairs
  module Part1
    def self.pairs(arr)
      arr.map.with_index { |e, i| arr[i + 1..].map { |f| [e, f] } }.flatten(1)
    end

    def self.k_closest_pairs(jboxes, k) # rubocop:disable Naming/MethodParameterName
      pairs(jboxes)
        .map { |pair| [*pair, pair[0].dist(pair[1])] }
        .sort { |a, b| a[2] <=> b[2] }[..k - 1]
    end

    def self.connect_k_closest(jboxes, k) # rubocop:disable Naming/MethodParameterName
      circuits = jboxes.map { |jb| [jb, Set.new([jb])] }.to_h
      k_closest_pairs(jboxes, k).each do |pair|
        left, right, = pair
        left_circuit = circuits[left]
        right_circuit = circuits[right]

        next if left_circuit.include? right # skip already connected jbs

        # connect circuits by adding all elements of right circuit to the
        # left circuit
        left_circuit.merge(right_circuit)

        # and updating the circuits map so all elements are associated with
        # the correct circuit
        right_circuit.each { |jb| circuits[jb] = left_circuit }
      end
      circuits.values.uniq
    end

    def self.multiply_three_largest(circuits)
      three_largest = circuits.map(&:size).sort { |a, b| b <=> a }[..2]
      three_largest.inject(1) { |a, b| a * b }
    end
  end
end

if __FILE__ == $PROGRAM_NAME
  puts 'Day 8: Playground'
  junctionboxes = Day8.load_junction_boxes('./day8_input.txt')
  circuits = Day8::Part1.connect_k_closest(junctionboxes, 1000)
  puts "Part 1: #{Day8::Part1.multiply_three_largest(circuits)}"
end
