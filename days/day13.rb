class Day13
  require_relative '../helpers/input_parser_helper'

  @@InputParserHelper = InputParserHelper.new(13)

  def part1()
    input = @@InputParserHelper.get_text().split("\n\n")

    limit = 100

    token_count = 0
    cost_a = 3
    cost_b = 1

    input.each do |prize|
      minimum_coins = nil

      match = prize.match(/A: X\+(?<a_x>\d+), Y\+(?<a_y>\d+)\n.+B: X\+(?<b_x>\d+), Y\+(?<b_y>\d+)\n.+X=(?<t_x>\d+), Y=(?<t_y>\d+)/)

      a_x = Integer(match["a_x"])
      a_y = Integer(match["a_y"])
      b_x = Integer(match["b_x"])
      b_y = Integer(match["b_y"])
      t_x = Integer(match["t_x"])
      t_y = Integer(match["t_y"])

      max_a_x = (t_x / a_x).floor()
      max_a_y = (t_y / a_y).floor()
      max_a = [max_a_x, max_a_y].min()

      (0..max_a).each do |amount|
        new_amount = max_a - amount

        if (new_amount > limit)
          next
        end

        rest_x = t_x - new_amount * a_x
        rest_y = t_y - new_amount * a_y

        if (rest_x % b_x == 0 && rest_y % b_y == 0)
          amount_b_x = rest_x / b_x
          amount_b_y = rest_y / b_y

          if (amount_b_x == amount_b_y && new_amount <= limit && amount_b_x <= limit)
            total_amount = new_amount * cost_a + amount_b_x * cost_b

            if (minimum_coins == nil || total_amount < minimum_coins)
              minimum_coins = total_amount
            end
          end
        end
      end

      if (minimum_coins != nil)
        token_count += minimum_coins
      end
    end

    return token_count
  end
end