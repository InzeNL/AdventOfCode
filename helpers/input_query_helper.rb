class InputQueryHelper
    require 'httparty'
    require_relative './configuration_helper'

    @@inputs_folder = "inputs"
    @@day_file_prefix = @@inputs_folder + "/day"
    @@day_file_suffix = ".txt"

    @@configuration_helper = ConfigurationHelper.new

    def ensure_inputs_folder()
        unless File.directory?(@@inputs_folder)
            Dir.mkdir(@@inputs_folder)
        end
    end

    def ensure_input(day)
        if (day.class == Integer)
            day = String(day)
        end

        if (day.class != String)
            raise StandardError, "Expected day to be of class String, was instead of type " + String(day.class)
        end

        ensure_inputs_folder()
        
        file_name = get_file_name(day)

        if (!File.file?(file_name))
            response = HTTParty.get(@@configuration_helper.get("input_url") % [day], headers: {
                "Cookie" => "session=" + @@configuration_helper.get("session_token")
            })
            
            if (response.code == 200)
                File.write(file_name, response.body)
            else
                raise StandardError, "Could not obtain input for day " + day + ", received status code " + String(response.code)
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