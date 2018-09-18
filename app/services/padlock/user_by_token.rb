module Padlock
  class UserByToken < Padlock::Base
    def initialize(params = {})
      @key = params[:token]
    end

    def call
      token&.user
    end

    private

    attr_reader :key

    def token
      @token ||= Token.find_by(key: key)
    end
  end
end
