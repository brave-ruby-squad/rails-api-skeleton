module Request
  module JsonHelpers
    ACCESS_TOKEN_KEY = 'X-Access-Token'.freeze

    def json_response
      @json_response ||= JSON.parse(response.body, symbolize_names: true)
    end

    def stub_auth!
      allow_any_instance_of(Padlock::Verifier).to receive(:call).and_return(user)
    end
  end
end
