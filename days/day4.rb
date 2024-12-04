class Day4
  require_relative '../helpers/input_parser_helper'

  def part1()
    word = "XMAS"
    lines = InputParserHelper.new(4).get_lines_split_on("")

    horizontal = []
    vertical = []
    diagonal_right = []
    diagonal_left = []

    lines.each do |line|
      horizontal << line.join("")
    end

    character_count = lines[0].length()
    line_count = lines.length()

    (0..character_count - 1).each do |x|
      vertical_line = ""
      diagonal_right_line = ""
      diagonal_left_line = ""
      
      (0..line_count - 1).each do |y|
        vertical_line += lines[y][x]

        if (x + y < character_count)
          diagonal_right_line += lines[y][x + y]
        end

        if (x - y >= 0)
          diagonal_left_line += lines[y][x - y]
        end
      end

      vertical << vertical_line
      diagonal_right << diagonal_right_line
      diagonal_left << diagonal_left_line
    end

    (1..line_count - 1).each do |y|
      diagonal_right_line = ""
      diagonal_left_line = ""

      (0..character_count - 1).each do |x|
        if (x + y < line_count)
          diagonal_right_line += lines[y + x][x]
        end
      end

      (0..character_count - 1).each do |tempx|
        x = (character_count - 1) - tempx
        if (y + x < line_count)
          diagonal_left_line += lines[y + x][tempx]
        end
      end
      
      diagonal_right << diagonal_right_line
      diagonal_left << diagonal_left_line
    end

    return count_word_in_arrays(word, [
      horizontal,
      vertical,
      diagonal_right,
      diagonal_left
    ])
  end

def count_word_in_arrays(word, arrays)
  sum = 0

  arrays.each do |array|
    sum += count_word_in_array(word, array)
  end

  return sum
end

  def count_word_in_array(word, array)
    sum = 0

    array.each do |line|
      sum += line.scan(/(#{word})/).count
      sum += line.scan(/(#{word.reverse})/).count
    end

    return sum
  end
end