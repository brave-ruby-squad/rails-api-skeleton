module Padlock
  class TokenGenerator < Padlock::Base
    def initialize(params = {})
      @user       = params[:user]
      @type       = params.fetch(:type, :auth)
      @expired_at = params.fetch(:expired_at, Time.zone.now + 1.month)
    end

    def call
      ExpireTokenJob.perform_at(token.expired_at, token_id: token.id) if token

      token
    end

    private

    attr_reader :user, :type, :expired_at

    def token
      @token ||= user.tokens.create(
        key:        SecureRandom.base64(TOKEL_LENGTH),
        key_type:   type,
        expired_at: expired_at
      )
    end
  end
end
