module Padlock
  class TokenGenerator < Padlock::Base
    def initialize(params = {})
      @user_id  = params[:user_id]
      @key_type = params.fetch(:key_type, :auth)
    end

    def call
      ExpireTokenJob.perform_at(token.expired_at, token_id: token.id) if token

      token
    end

    private

    attr_reader :user_id, :key_type

    def user
      @user ||= User.find_by(id: user_id)
    end

    def key
      @key ||= SecureRandom.urlsafe_base64(AUTH_TOKEN_LENGTH)
    end

    def expired_at
      @expired_at ||= case key_type
                      when :auth
                        Time.zone.now + 1.month
                      when :verification
                        Time.zone.now + 1.hour
                      end
    end

    def token
      @token ||= user.tokens.create(
        key_type:   key_type,
        key:        key,
        expired_at: expired_at
      )
    end
  end
end
