class Day5
  require_relative '../helpers/input_parser_helper'

  @@InputParserHelper = InputParserHelper.new(5)

  def part1()
    @instructions = Hash.new

    @sum_of_middles = 0

    @@InputParserHelper.get_lines_and_perform(method(:parse_instructions))

    return @sum_of_middles
  end

  def parse_instructions(line)
    if (line.count("|") > 0)
      split_line = line.split("|")
      second = split_line[1]

      if (@instructions[second] == nil)
        @instructions[second] = []
      end

      @instructions[second] << split_line[0]
      return
    end

    if (line.count(",") == 0)
      return
    end

    passed_numbers = []

    split_line = line.split(",")
    split_line.each do |entry|
      if (@instructions[entry] == nil)
        @instructions[entry] = []
      end

      is_valid = true

      @instructions[entry].each do |first|
        if (passed_numbers.count(first) == 0 && split_line.count(first) > 0)
          is_valid = false
        end
      end

      if (is_valid == false)
        return
      end

      passed_numbers << entry
    end

    @sum_of_middles += get_middle_of_line(split_line)
  end

  def get_middle_of_line(line)
    return Integer(line[(line.length() + 1) / 2 - 1])
  end

  def part2()
    @instructions = Hash.new

    @sum_of_middles = 0

    @@InputParserHelper.get_lines_and_perform(method(:parse_instructions_and_fix_broken_lines))

    return @sum_of_middles
  end

  def parse_instructions_and_fix_broken_lines(line)
    if (line.count("|") > 0)
      split_line = line.split("|")
      second = split_line[1]

      if (@instructions[second] == nil)
        @instructions[second] = []
      end

      @instructions[second] << split_line[0]
      return
    end

    if (line.count(",") == 0)
      return
    end

    passed_numbers = []

    is_valid = true

    split_line = line.split(",")
    split_line.each do |entry|
      if (@instructions[entry] == nil)
        @instructions[entry] = []
      end

      @instructions[entry].each do |first|
        if (passed_numbers.count(first) == 0 && split_line.count(first) > 0)
          is_valid = false
          break
        end
      end

      if (is_valid == false)
        break
      end

      passed_numbers << entry
    end

    if (is_valid)
      return
    end

    ordered_line = []

    while (ordered_line.length() < split_line.length())
      split_line.each do |entry|
        if (ordered_line.count(entry) > 0)
          next
        end

        should_add = true

        @instructions[entry].each do |first|
          if (split_line.count(first) > 0 && ordered_line.count(first) == 0)
            should_add = false
          end
        end

        if (should_add)
          ordered_line << entry
        end
      end
    end

    @sum_of_middles += get_middle_of_line(ordered_line)
  end
end