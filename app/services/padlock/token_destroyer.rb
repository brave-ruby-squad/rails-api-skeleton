module Padlock
  class TokenDestroyer < Padlock::Base
    def initialize(params = {})
      @token = params[:token]
    end

    def call
      token.delete
    end

    private

    attr_reader :token
  end
end
