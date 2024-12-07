class Day7
  require_relative '../helpers/input_parser_helper'

  @@InputParserHelper = InputParserHelper.new(7)
  
  def part1()
    lines = @@InputParserHelper.get_lines_split_on(": ")

    total = 0

    lines.each do |line|
      target = Integer(line[0])
      numbers = line[1].split(/\s+/).map(&:to_i)
      has_solution = has_solution(target, numbers)

      if (has_solution)
        total += target
      end
    end

    return total
  end

  def has_solution(target, numbers, current_result = 0)
    if (numbers.length() == 0)
      return target == current_result
    end

    next_number = numbers[0]
    
    if (current_result == 0)
      return has_solution(target, numbers.drop(1), next_number)
    end

    return has_solution(target, numbers.drop(1), current_result + next_number) || has_solution(target, numbers.drop(1), current_result * next_number)
  end

end