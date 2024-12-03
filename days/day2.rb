class Day2
  require_relative '../helpers/input_parser_helper'

  @@input_parser_helper = InputParserHelper.new(2)

  def initialize()
    
  end

  def part1()
    @safe_reports = 0
    @@input_parser_helper.get_lines_and_perform(method(:count_safe_reports))

    puts @safe_reports
  end

  def part2()
    @safe_reports_with_tolerance = 0
    @@input_parser_helper.get_lines_and_perform(method(:count_safe_reports_with_tolerance))
    
    puts @safe_reports_with_tolerance
  end

  def count_safe_reports_with_tolerance(line)
    reports = line.split(/\W/)
    parsed_reports = []

    reports.each do |report|
      parsed_reports << Integer(report)
    end

    is_safe = false

    (0..parsed_reports.length() - 1).each do |index|
      if (parsed_report_is_valid(parsed_reports.dup.tap{|i| i.delete_at(index)}))
        is_safe = true
        break
      end
    end

    if (is_safe)
      @safe_reports_with_tolerance += 1
    end
  end

  def parsed_report_is_valid(parsed_reports)
    is_safe = true

    sorted_parsed_reports = parsed_reports.sort
    reverse_sorted_parsed_reports = parsed_reports.sort.reverse

    if (parsed_reports == sorted_parsed_reports || parsed_reports == reverse_sorted_parsed_reports)
      (1..parsed_reports.length() - 1).each do |index|
        difference = (parsed_reports[index] - parsed_reports[index - 1]).abs
        if (difference < 1 || difference > 3)
          
          is_safe = false
          break
        end
      end
    else
      is_safe = false
    end

    return is_safe
  end 

  def count_safe_reports(line)
    reports = line.split(/\W/)
    parsed_reports = []

    reports.each do |report|
      parsed_reports << Integer(report)
    end

    if (parsed_report_is_valid(parsed_reports))
      @safe_reports += 1
    end
  end
end