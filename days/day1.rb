class Day1
    require_relative '../helpers/input_parser_helper'

    def initialize()
        @leftColumn = []
        @rightColumn = []

        InputParserHelper.new(1).get_lines_and_perform(method(:assign_numbers_to_columns))
    end
    
    def assign_numbers_to_columns(line) 
        splitString = line.split(/\s+/)

        @leftColumn << Integer(splitString[0])
        @rightColumn << Integer(splitString[1])
    end

    def part1()
        sortedLeftColumn = @leftColumn.sort
        sortedRightColumn = @rightColumn.sort

        totalDistance = 0

        sortedLeftColumn.each_with_index do |left, index|
            totalDistance += (left - sortedRightColumn[index]).abs
        end

        return totalDistance
    end

    def part2()
        similarityScore = 0

        @leftColumn.each do |left|
            similarityScore += left * @rightColumn.count(left)
        end

        return similarityScore
    end
end