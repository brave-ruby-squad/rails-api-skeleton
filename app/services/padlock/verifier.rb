module Padlock
  class Verifier < ::Callable
    def initialize(headers = {})
      @headers = headers
    end

    def call
      user
    end

    private

    attr_reader :headers

    def user
      @user ||= User.find(decoded_auth_token[:user_id]) if decoded_auth_token
    end

    def decoded_auth_token
      @decoded_auth_token ||= JwToken::Decrypt.call(http_auth_token)
    end

    def http_auth_token
      headers['X-Access-Token'].to_s.split(' ').last
    end
  end
end
