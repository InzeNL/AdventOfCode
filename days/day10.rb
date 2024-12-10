class Day10
  require_relative '../helpers/input_parser_helper'

  @@InputParserHelper = InputParserHelper.new(10)

  def part1()
    lines = @@InputParserHelper.get_lines()

    sum = 0

    joined_lines = lines.join()

    i = -1
    coordinates = []
    while (i = joined_lines.index('0', i + 1))
      x = i % lines[0].length()
      y = (i / lines[0].length()).floor()

      coordinates << [x, y]
    end

    coordinates.each do |coordinate|
      sum += get_trail_heads(lines, coordinate)
    end

    return sum
  end

  def get_trail_heads(lines, coordinate, get_ratings = false)
    x = coordinate[0]
    y = coordinate[1]

    current_number = Integer(lines[y][x])

    if (current_number == 9)
      return [coordinate]
    end

    up_x = x
    up_y = y - 1

    right_x = x + 1
    right_y = y

    down_x = x
    down_y = y + 1

    left_x = x - 1
    left_y = y

    up = get_integer_value_for_coordinate(lines, up_x, up_y)
    right = get_integer_value_for_coordinate(lines, right_x, right_y)
    down = get_integer_value_for_coordinate(lines, down_x, down_y)
    left = get_integer_value_for_coordinate(lines, left_x, left_y)

    coordinates = []

    if (up == current_number + 1)
      coordinates += get_trail_heads(lines, [up_x, up_y])
    end

    if (right == current_number + 1)
      coordinates += get_trail_heads(lines, [right_x, right_y])
    end

    if (down == current_number + 1)
      coordinates += get_trail_heads(lines, [down_x, down_y])
    end

    if (left == current_number + 1)
      coordinates += get_trail_heads(lines, [left_x, left_y])
    end

    if (current_number == 0)
      if (get_ratings)
        return coordinates.count()
      else
        return coordinates.uniq().count()
      end
    else
      return coordinates
    end
  end

  def get_integer_value_for_coordinate(lines, x, y)
    if (x < 0 || x >= lines[0].length() || y < 0 || y >= lines.length())
      return nil
    end

    return Integer(lines[y][x])
  end

  def part2()
    lines = @@InputParserHelper.get_lines()

    sum = 0

    joined_lines = lines.join()

    i = -1
    coordinates = []
    while (i = joined_lines.index('0', i + 1))
      x = i % lines[0].length()
      y = (i / lines[0].length()).floor()

      coordinates << [x, y]
    end

    coordinates.each do |coordinate|
      sum += get_trail_heads(lines, coordinate, true)
    end

    return sum
  end
end