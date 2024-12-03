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