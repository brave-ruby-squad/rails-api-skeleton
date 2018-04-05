module Padlock
  class Authenticator < ::Callable
    def initialize(params)
      @email    = params[:email]
      @password = params[:password]
    end

    def call
      JwToken::Encrypt.call(payload: payload) if user_valid?
    end

    private

    attr_reader :email, :password

    def payload
      {
        user_id: user.id
      }
    end

    def user
      @user ||= User.find_by(email: email)
    end

    def user_valid?
      user.present? && user&.authenticate(password)
    end
  end
end
