class Day11
  require_relative '../helpers/input_parser_helper'

  @@InputParserHelper = InputParserHelper.new(11)

  def part1()
    stones = @@InputParserHelper.get_text().split(/\s+/).map(&:to_i)

    return blink_stones(stones, 25)
  end

  def part2()
    stones = @@InputParserHelper.get_text().split(/\s+/).map(&:to_i)

    return blink_stones(stones, 75)
  end

  def blink_stones(stones, amount)
    stone_count = 0

    stones.each do |stone|
      stone_count += blink_stone(stone, amount)
    end

    return stone_count
  end

  def blink_stone(stone, amount)
    if (amount == 0)
      return 1
    end
    
    if (stone == 0)
      return blink_stone(1, amount - 1)
    end

    stone_string = String(stone)
    stone_string_length = stone_string.length()
    if (stone_string_length % 2 == 0)
      return blink_stone(stone_string[0, stone_string_length / 2].to_i(), amount - 1) + blink_stone(stone_string[stone_string_length / 2..-1].to_i(), amount - 1)
    end

    return blink_stone(stone * 2024, amount - 1)
  end
end