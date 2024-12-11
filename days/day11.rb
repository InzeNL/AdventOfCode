class Day11
  require_relative '../helpers/input_parser_helper'

  @@InputParserHelper = InputParserHelper.new(11)

  def part1()
    stones = @@InputParserHelper.get_text().split(/\s+/).map(&:to_i)

    return blink_stones(stones, 25).count()
  end

  def blink_stones(stones, amount)
    (1..amount).each do |_|
      new_stones = []

      stones.each do |stone|
        added_stones = blink_stone(stone)
        added_stones.each do |added_stone|
          new_stones << added_stone
        end
      end

      stones = new_stones
    end

    return stones
  end

  def blink_stone(stone)
    if (stone == 0)
      return [1]
    end

    stone_string = String(stone)
    stone_string_length = stone_string.length()
    if (stone_string_length % 2 == 0)
      return [stone_string[0, stone_string_length / 2], stone_string[stone_string_length / 2..-1]].map(&:to_i)
    end

    return [stone * 2024]
  end
end