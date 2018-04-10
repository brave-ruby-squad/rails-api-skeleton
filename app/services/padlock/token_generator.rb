module Padlock
  class TokenGenerator < Padlock::Base
    def initialize(params = {})
      @user       = params[:user]
      @type       = params[:type] || :auth
      @expired_at = params[:expired_at] || Time.zone.now + 1.month
    end

    def call
      user.tokens.create(
        key:        SecureRandom.base64(18),
        key_type:   type,
        expired_at: expired_at
      )
    end

    private

    attr_reader :user, :type, :expired_at
  end
end
