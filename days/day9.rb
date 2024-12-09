class Day9
  require_relative '../helpers/input_parser_helper'

  @@InputParserHelper = InputParserHelper.new(9)

  def part1()
    source = @@InputParserHelper.get_text().gsub(/\s/, "").split("")

    target = []

    source.each.with_index do |element, index|
      id = (index / 2).floor()
      is_file = index % 2 == 0

      if (is_file)
        character = id
      else
        character = "."
      end

      (1..Integer(element)).each do |element_count|
        target << character
      end
    end

    split_reversed_target = target.reverse

    split_reversed_target.each.with_index do |current_file, index|
      if (current_file == ".")
        next
      end

      actual_index = target.length() - index - 1

      next_position = target.find_index(".")

      if (actual_index <= next_position)
        break
      end

      target[next_position] = current_file
      target[actual_index] = "."
    end

    checksum = 0

    target.each.with_index do |current_file, index|
      if (current_file == ".")
        break
      end

      checksum += current_file * index
    end

    return checksum
  end
end