class Day12
  require_relative '../helpers/input_parser_helper'

  @@InputParserHelper = InputParserHelper.new(12)

  def part1()
    lines = @@InputParserHelper.get_lines()

    sum = 0

    non_marked_plot = get_non_marked_plot_position(lines)
    while (non_marked_plot != nil)
      sum += get_entire_plot(lines, non_marked_plot)

      non_marked_plot = get_non_marked_plot_position(lines)
    end

    return sum
  end
  
  def part2()
    lines = @@InputParserHelper.get_lines()

    sum = 0

    non_marked_plot = get_non_marked_plot_position(lines)
    while (non_marked_plot != nil)
      sum += get_entire_plot_sides(lines, non_marked_plot)

      non_marked_plot = get_non_marked_plot_position(lines)
    end

    return sum
  end

  def get_non_marked_plot_position(lines)
    index = lines.join("").index(/[^-]/)

    if (index == nil)
      return nil
    end

    x = index % lines[0].length()
    y = (index / lines[0].length()).floor()

    return [x, y]
  end

  def get_entire_plot(marked_plots, coordinate)
    x = coordinate[0]
    y = coordinate[1]

    marked_coordinates = [[x, y]]

    character = marked_plots[y][x]

    marked_plots[y][x] = '-'

    get_next_positions(marked_plots, marked_coordinates, coordinate, character)

    return marked_coordinates.count() * get_perimeter(marked_coordinates)
  end

  def get_entire_plot_sides(marked_plots, coordinate)
    x = coordinate[0]
    y = coordinate[1]

    marked_coordinates = [[x, y]]

    character = marked_plots[y][x]

    marked_plots[y][x] = '-'

    get_next_positions(marked_plots, marked_coordinates, coordinate, character)

    return marked_coordinates.count() * get_side_count(marked_coordinates)
  end

  def get_perimeter(coordinates)
    perimeter = 0

    coordinates.each do |coordinate|
      x = coordinate[0]
      y = coordinate[1]

      if (coordinates.count([x, y - 1]) == 0)
        perimeter += 1
      end
      
      if (coordinates.count([x + 1, y]) == 0)
        perimeter += 1
      end
      
      if (coordinates.count([x, y + 1]) == 0)
        perimeter += 1
      end
      
      if (coordinates.count([x - 1, y]) == 0)
        perimeter += 1
      end
    end

    return perimeter
  end

  def get_side_count(coordinates)
    sides = 0

    has_no_up = []
    has_no_right = []
    has_no_down = []
    has_no_left = []

    coordinates.each do |coordinate|
      x = coordinate[0]
      y = coordinate[1]

      if (coordinates.count([x, y - 1]) == 0)
        has_no_up << coordinate
      end
      
      if (coordinates.count([x + 1, y]) == 0)
        has_no_right << coordinate
      end
      
      if (coordinates.count([x, y + 1]) == 0)
        has_no_down << coordinate
      end
      
      if (coordinates.count([x - 1, y]) == 0)
        has_no_left << coordinate
      end
    end

    has_no_up_ys = has_no_up.map { |up| up[1] }.uniq()

    has_no_up_ys.each do |y|
      xs_for_y = has_no_up.select { |item| item[1] == y }.map { |item| item[0] }

      xs_for_y.each do |x|
        if (xs_for_y.count(x - 1) == 0)
          sides += 1
        end
      end
    end
    
    has_no_right_xs = has_no_right.map { |right| right[0] }.uniq()

    has_no_right_xs.each do |x|
      ys_for_x = has_no_right.select { |item| item[0] == x }.map { |item| item[1] }

      ys_for_x.each do |y|
        if (ys_for_x.count(y - 1) == 0)
          sides += 1
        end
      end
    end
    
    has_no_down_ys = has_no_down.map { |down| down[1] }.uniq()

    has_no_down_ys.each do |y|
      xs_for_y = has_no_down.select { |item| item[1] == y }.map { |item| item[0] }

      xs_for_y.each do |x|
        if (xs_for_y.count(x - 1) == 0)
          sides += 1
        end
      end
    end
    
    has_no_left_xs = has_no_left.map { |left| left[0] }.uniq()

    has_no_left_xs.each do |x|
      ys_for_x = has_no_left.select { |item| item[0] == x }.map { |item| item[1] }

      ys_for_x.each do |y|
        if (ys_for_x.count(y - 1) == 0)
          sides += 1
        end
      end
    end

    return sides
  end

  def get_next_positions(marked_plots, marked_coordinates, coordinate, character)
    x = coordinate[0]
    y = coordinate[1]

    up_x = x
    up_y = y - 1

    if (is_part_of_plot(marked_plots, marked_coordinates, up_x, up_y, character))
      marked_plots[up_y][up_x] = '-'
      marked_coordinates << [up_x, up_y]
      get_next_positions(marked_plots, marked_coordinates, [up_x, up_y], character)
    end

    right_x = x + 1
    right_y = y

    if (is_part_of_plot(marked_plots, marked_coordinates, right_x, right_y, character))
      marked_plots[right_y][right_x] = '-'
      marked_coordinates << [right_x, right_y]
      get_next_positions(marked_plots, marked_coordinates, [right_x, right_y], character)
    end

    down_x = x
    down_y = y + 1

    if (is_part_of_plot(marked_plots, marked_coordinates, down_x, down_y, character))
      marked_plots[down_y][down_x] = '-'
      marked_coordinates << [down_x, down_y]
      get_next_positions(marked_plots, marked_coordinates, [down_x, down_y], character)
    end

    left_x = x - 1
    left_y = y

    if (is_part_of_plot(marked_plots, marked_coordinates, left_x, left_y, character))
      marked_plots[left_y][left_x] = '-'
      marked_coordinates << [left_x, left_y]
      get_next_positions(marked_plots, marked_coordinates, [left_x, left_y], character)
    end
  end

  def is_part_of_plot(marked_plots, marked_coordinates, x, y, character)
    if (x < 0 || x >= marked_plots[0].length() || y < 0 || y >= marked_plots.length())
      return false
    end

    if (marked_coordinates.count([x, y]) > 0)
      return false
    end

    return marked_plots[y][x] == character
  end
end