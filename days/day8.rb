class Day8
    require_relative '../helpers/input_parser_helper'

    @@InputParserHelper = InputParserHelper.new(8)

    def part1()
        input = @@InputParserHelper.get_lines()

        allowed_characters = /\w/
        frequencies = input.join().gsub("\n", "").split("").uniq().select{|character| allowed_characters.match?(character)}

        map = {}

        frequencies.each do |frequency|
            map[frequency] = []
        end

        input.each.with_index do |line, index|
            frequencies.each do |frequency|
                jindex = -1
                while jindex = line.index(frequency, jindex + 1)
                    map[frequency] << [jindex, index]
                end
            end
        end

        antinodes = []

        width = input[0].length()
        height = input.length()

        frequencies.each do |frequency|
            nodes = map[frequency]

            nodes.each.with_index do |node, index|
                target_nodes = nodes.dup.tap{|i| i.delete_at(index)}

                target_nodes.each do |target_node|
                    diff_x = target_node[0] - node[0]
                    diff_y = target_node[1] - node[1]

                    left_x = node[0] - diff_x
                    left_y = node[1] - diff_y

                    if (left_x >= 0 && left_x < width && left_y >= 0 && left_y < height)
                        antinodes << [left_x, left_y]
                    end

                    right_x = target_node[0] + diff_x
                    right_y = target_node[1] + diff_y

                    if (right_x >= 0 && right_x < width && right_y >= 0 && right_y < height)
                        antinodes << [right_x, right_y]
                    end
                end
            end
        end

        return antinodes.uniq().length()
    end
end