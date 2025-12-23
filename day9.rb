# frozen_string_literal: true

# Day 9: Movie Theater
module Day9
  def self.load_floor_pattern(path)
    IO.readlines(path)
      .map { |ln| ln.split(',').map { |val| Integer(val) } }
  end

  def self.pairs(arr)
    arr.map.with_index { |e, i| arr[i + 1..].map { |f| [e, f] } }.flatten(1)
  end

  def self.min_max_components(pair)
    tile1, tile2 = pair
    xmin = [tile1[0], tile2[0]].min
    xmax = [tile1[0], tile2[0]].max

    ymin = [tile1[1], tile2[1]].min
    ymax = [tile1[1], tile2[1]].max

    [xmin, xmax, ymin, ymax]
  end

  def self.rectangle_area(pair)
    xmin, xmax, ymin, ymax = min_max_components(pair)
    xdiff = xmax - xmin + 1
    ydiff = ymax - ymin + 1
    xdiff * ydiff
  end

  def self.largest_rectangle_area_between_red_tiles(floor_pattern)
    pairs(floor_pattern).map(&method(:rectangle_area)).max
  end
end

if __FILE__ == $PROGRAM_NAME
  puts 'Day 9: Movie Theater'
  floor_pattern = Day9.load_floor_pattern('./day9_input.txt')
  puts "Part 1: #{Day9.largest_rectangle_area_between_red_tiles(floor_pattern)}"

end
