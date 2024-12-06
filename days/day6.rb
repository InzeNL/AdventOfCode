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

  def get_marked_walk_output(lines)
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

    return lines.join("")
  end

  def part1()
    lines = @@InputParserHelper.get_lines()
    lines = get_marked_walk_output(lines)

    return lines.count("X")
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

  def part2()
    lines = @@InputParserHelper.get_lines()
    stored_lines = lines.map(&:clone)

    start_guard_position = find_guard(stored_lines)
    start_guard_direction = @@current_direction

    stored_lines[start_guard_position[1]][start_guard_position[0]] = "."

    guard_move_count = 0

    loop_count = 0

    marked_walk_output = get_marked_walk_output(lines)

    i = -1
    indexes = []
    while (i = marked_walk_output.index('X', i + 1))
      x = i % lines[0].length()
      y = (i / lines[0].length()).floor()

      indexes << [x, y]
    end

    lines = []

    indexes.each do |index|
      x_replace = index[0]
      y_replace = index[1]
      
        lines = stored_lines.map(&:clone)
        lines[y_replace][x_replace] = "#"
        guard_position = start_guard_position.map(&:clone)
        @@current_direction = start_guard_direction
        has_rotated = false
        looped = 0

        while (true)      
          next_position = get_next_position(guard_position)
          x = next_position[0]
          y = next_position[1]
    
          if (x < 0 || x >= lines[0].length() || y < 0 || y >= lines.length())
            break
          end
    
          next_character = lines[y][x]

          x_now = guard_position[0]
          y_now = guard_position[1]

          if (next_character == "#")
            if (lines[y_now][x_now] == "X")
              if (looped >= 3)
                loop_count += 1
                break
              end
              
              looped += 1
            end

            rotate_guard()
            has_rotated = true
          else
            if (lines[y_now][x_now] != "X")
              lines[y_now][x_now] = "X"
            end

            guard_position = next_position
            guard_move_count += 1
          end
        end
    end
    
    return loop_count
  end
end