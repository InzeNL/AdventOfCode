#!/usr/bin/env ruby

if __FILE__ == $0
    leftColumn = []
    rightColumn = []

    file = File.open("inputs/day1.txt", "r")
    file.each_line do |line|
        splitString = line.split(" ")

        leftColumn << Integer(splitString[0])
        rightColumn << Integer(splitString[1])
    end
    file.close

    sortedLeftColumn = leftColumn.sort
    sortedRightColumn = rightColumn.sort

    totalDistance = 0

    sortedLeftColumn.each_with_index do |left, index|
        totalDistance += (left - sortedRightColumn[index]).abs
    end

    puts totalDistance

    # Part B
    similarityScore = 0

    leftColumn.each do |left|
        similarityScore += left * rightColumn.count(left)
    end

    puts similarityScore
end