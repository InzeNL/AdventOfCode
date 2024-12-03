class InputParserHelper
    require_relative './input_query_helper'

    def initialize(day)
        input_query_helper = InputQueryHelper.new

        if (day.class == Integer)
            day = String(day)
        end

        if (day.class != String)
            raise StandardError, "Expected day to be of class String, was instead of type " + String(day.class)
        end

        @day = day

        input_query_helper.ensure_input(@day)
        @@file_name = input_query_helper.get_file_name(@day)
    end

    def get_text()
        return File.read(@@file_name)
    end

    def get_lines()
        lines = []

        file = File.open(@@file_name, "r")

        file.each_line do |line|
            lines << line
        end

        lines
    end

    def get_lines_split_on_whitespace()
        return get_lines_split_on(/\W+/)
    end

    def get_lines_split_on(splitter)
        if (splitter.class == Integer)
            splitter = String(splitter)
        end

        if (splitter.class != Regexp && splitter.class != String)
            raise StandardError, "Expected day to be of class Regexp or String, was instead of type " + String(day.class)
        end

        puts splitter.class
    end
end