require 'active_resource'

ActiveSupport::JSON::Encoding.use_standard_json_time_format = true
ActiveSupport.parse_json_times = true

ActiveResource::Base.include_format_in_path = false
ActiveResource::Base.site = "http://git.repohub.dev/"