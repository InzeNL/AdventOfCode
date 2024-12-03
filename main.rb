class ConfigurationHelper
    require "json"

    @@config_file_location = "config.json"

    def initialize()
        @configuration = JSON.load File.read(@@config_file_location)
    end

    def get(key)
        @configuration[key]
    end
end

class InputQueryHelper
    require 'httparty'

    @@day_file_prefix = "inputs/day"
    @@day_file_suffix = ".txt"

    @@configuration_helper = ConfigurationHelper.new

    def ensure_input(day)
        if (day.class != Integer)
            raise StandardError, "Expected day to be of class Integer, was instead of type " + String(day.class)
        end
        
        file_name = get_file_name(day)

        if (!File.file?(file_name))
            response = HTTParty.get(@@configuration_helper.get("input_url") % [String(day)], headers: {
                "Cookie" => "session=" + @@configuration_helper.get("session_token")
            })
            
            if (response.code == 200)
                File.write(file_name, response.body)
            else
                raise StandardError, "Could not obtain input for day " + String(day) + ", received status code " + String(response.code)
            end
        end
    end

    def get_file_name(day)
        if (day.class == Integer)
            day = String(day)
        end

        if (day.class != String)
            raise StandardError, "Expected day to be of class String, was instead of type " + String(day.class)
        end

        return @@day_file_prefix + String(day) + @@day_file_suffix
    end
end