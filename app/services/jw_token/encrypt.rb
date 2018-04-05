module JwToken
  class Encrypt < ::Callable
    def initialize(params)
      @payload    = params[:payload]
      @expiration = params.fetch(:expiration, 24.hours.from_now)
    end

    def call
      JWT.encode(payload_with_expiration, Rails.application.secrets.secret_key_base)
    end

    def payload_with_expiration
      payload.merge(exp: expiration.to_i)
    end

    private

    attr_reader :payload, :expiration
  end
end
