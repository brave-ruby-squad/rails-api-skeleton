module Request
  module JsonHelpers
    ACCESS_TOKEN_KEY = 'X-Access-Token'.freeze

    def json_response
      @json_response ||= JSON.parse(response.body, symbolize_names: true)
    end
  end
end
