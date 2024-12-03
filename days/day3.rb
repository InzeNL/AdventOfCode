class Day3
  require_relative "../helpers/input_parser_helper"

  def part1()
    text = InputParserHelper.new(3).get_text()

    sum = 0;

    text.scan(/mul\((\d+?),(\d+?)\)/).each do |multiplication|
      sum += Integer(multiplication[0]) * Integer(multiplication[1])
    end

    return sum
  end

  def part2()
    text = InputParserHelper.new(3).get_text()

    sum = 0
    add = true

    text.scan(/((don't)|(do\(\))|(mul\((\d+?),(\d+?)\)))/).each do |result|
      if (result[1] != nil)
        add = false
      end
      if (result[2] != nil)
        add = true
      end
      if (add && result[3] != nil)
        sum += Integer(result[4]) * Integer(result[5])
      end
    end

    return sum
  end
end