module JwToken
  class Decrypt < ::Callable
    def initialize(token)
      @token = token
    end

    def call
      body&.deep_symbolize_keys
    rescue JWT::DecodeError
      nil
    end

    private

    attr_reader :token

    def body
      @body ||= JWT.decode(token, Rails.application.secrets.secret_key_base).first
    end
  end
end
