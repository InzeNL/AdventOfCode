if ARGV[0] == nil
  require 'benchmark'
  
  days = []
  parts = []
  results = []
  runtimes = []
  total_runtime = Benchmark::Tms.new

  def format_runtime(runtime)
    return String(runtime).split(/\s+/)[-1][0..-2]
  end

  (1..25).each do |day|
    day = String(day)

    begin
      require_relative "./days/day" + day
    rescue LoadError
      break
    end

    dayClass = Object.const_get("Day" + day).new

    result = nil

    begin
      runtime = Benchmark.measure {
        result = dayClass.send("part1")
      }

      total_runtime += runtime
      
      days << day
      parts << "1"
      results << String(result)
      runtimes << format_runtime(runtime)
      
    rescue NoMethodError
    end
    
    begin
      runtime = Benchmark.measure {
        result = dayClass.send("part2")
      }
      total_runtime += runtime

      days << day
      parts << "2"
      results << String(result)
      runtimes << format_runtime(runtime)
    rescue NoMethodError
    end
  end

  def max_string_length_in_array_and_term(array, term, additional_max = 0)
    mapped_array = array.map do |item|
      item.length
    end

    return [mapped_array.sort.reverse[0], term.length, additional_max].max
  end

  def characters_to_add(term, required_length, character = " ")
    return character * ([0, required_length - term.length].max)
  end

  @character_padding = 2

  def format_with_characters_in_front(term, required_length, character = " ")
    return character * @character_padding + term + characters_to_add(term, required_length, character) + character * @character_padding
  end

  def format_with_characters_in_back(term, required_length, character = " ")
    return character * @character_padding + characters_to_add(term, required_length, character) + term + character * @character_padding
  end

  total_row_name = "Total"
  day_column_name = "Day"
  part_column_name = "Part"
  result_column_name = "Result"
  runtime_column_name = "Runtime (seconds)"

  max_day_length = max_string_length_in_array_and_term(days, day_column_name, total_row_name.length)
  max_part_length = max_string_length_in_array_and_term(parts, part_column_name)
  max_result_length = max_string_length_in_array_and_term(results, result_column_name)
  max_runtime_length = max_string_length_in_array_and_term(runtimes, runtime_column_name, format_runtime(total_runtime).length)

  puts "|" + format_with_characters_in_front("-", max_day_length, "-") + "|"  + format_with_characters_in_front("-", max_part_length, "-") + "|"  + format_with_characters_in_front("-", max_result_length, "-") + "|"  + format_with_characters_in_front("-", max_runtime_length, "-") + "|"
  puts "|"  + format_with_characters_in_front(day_column_name, max_day_length) + "|"  + format_with_characters_in_front(part_column_name, max_part_length) + "|"  + format_with_characters_in_front(result_column_name, max_result_length) + "|"  + format_with_characters_in_front(runtime_column_name, max_runtime_length) + "|"
  puts "|" + format_with_characters_in_front("-", max_day_length, "-") + "|"  + format_with_characters_in_front("-", max_part_length, "-") + "|"  + format_with_characters_in_front("-", max_result_length, "-") + "|"  + format_with_characters_in_front("-", max_runtime_length, "-") + "|"

  days.each.with_index do |day, index|
    if (index > 0 && day == days[index - 1])
      day = ""
    elsif (index > 0)
      puts "|" + format_with_characters_in_front("-", max_day_length, "-") + "|"  + format_with_characters_in_front("-", max_part_length, "-") + "|"  + format_with_characters_in_front("-", max_result_length, "-") + "|"  + format_with_characters_in_front("-", max_runtime_length, "-") + "|"
    end

    puts "|"  + format_with_characters_in_back(day, max_day_length) + "|"  + format_with_characters_in_back(parts[index], max_part_length) + "|"  + format_with_characters_in_back(results[index], max_result_length) + "|"  + format_with_characters_in_back(runtimes[index], max_runtime_length) + "|"
  end

  puts "|" + format_with_characters_in_front("-", max_day_length, "-") + "-"  + format_with_characters_in_front("-", max_part_length, "-") + "-"  + format_with_characters_in_front("-", max_result_length, "-") + "|"  + format_with_characters_in_front("-", max_runtime_length, "-") + "|"
  puts "|" + format_with_characters_in_back(total_row_name, max_day_length) + " "  + format_with_characters_in_back("", max_part_length) + " "  + format_with_characters_in_back("", max_result_length) + "|"  + format_with_characters_in_back(format_runtime(total_runtime), max_runtime_length) + "|"
  puts "|" + format_with_characters_in_front("-", max_day_length, "-") + "-"  + format_with_characters_in_front("-", max_part_length, "-") + "-"  + format_with_characters_in_front("-", max_result_length, "-") + "|"  + format_with_characters_in_front("-", max_runtime_length, "-") + "|"

else
  require_relative "./days/day" + ARGV[0]

  dayClass = Object.const_get("Day" + ARGV[0]).new

  if ARGV[1]
    puts "Part " + ARGV[1] + " result: " + String(dayClass.send("part" + ARGV[1]))
  else
    puts "Part 1 result: " + String(dayClass.send("part1"))
    puts "Part 2 result: " + String(dayClass.send("part2"))
  end  
end