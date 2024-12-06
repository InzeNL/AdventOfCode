class Day6
  require_relative '../helpers/input_parser_helper'

  @@InputParserHelper = InputParserHelper.new(6)

  @@guard_directions = [
    "^",
    ">",
    "v",
    "<"
  ]

  @@current_direction = nil

  def part1()
    lines = @@InputParserHelper.get_lines()

    guard_position = find_guard(lines)

    guard_move_count = 0

    while (true)
      x_now = guard_position[0]
      y_now = guard_position[1]
      lines[y_now][x_now] = "X"

      next_position = get_next_position(guard_position)
      x = next_position[0]
      y = next_position[1]

      if (x < 0 || x >= lines[0].length() || y < 0 || y >= lines.length())
        break
      end

      next_character = lines[y][x]

      if (next_character == "#")
        rotate_guard()
      else
        guard_position = next_position
        guard_move_count += 1
      end
    end

    return lines.join("").count("X")
  end

  def find_guard(lines)
    guard_position = []

    lines.each.with_index do |line, index|
      jindex = nil

      @@guard_directions.each do |direction|
        jindex = line.index(direction)

        if (jindex != nil)
          @@current_direction = direction
          break
        end
      end

      if (jindex != nil)
        guard_position = [jindex, index]
        break
      end
    end

    return guard_position
  end

  def get_next_position(guard_position)
    x = guard_position[0]
    y = guard_position[1]

    if (@@current_direction == "^")
      return [x, y - 1]
    end

    if (@@current_direction == ">")
      return [x + 1, y]
    end

    if (@@current_direction == "v")
      return [x, y + 1]
    end

    if (@@current_direction == "<")
      return [x - 1, y]
    end
  end

  def rotate_guard()
    if (@@current_direction == "^")
      @@current_direction = ">"
      return
    end

    if (@@current_direction == ">")
      @@current_direction = "v"
      return
    end

    if (@@current_direction == "v")
      @@current_direction = "<"
      return
    end

    if (@@current_direction == "<")
      @@current_direction = "^"
      return
    end
  end
end