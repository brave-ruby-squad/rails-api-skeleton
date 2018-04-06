module V1
  module Padlock
    module Registrations
      class Create < ::Callable
        def initialize(params = {})
          @email                 = params[:email]
          @phone                 = params[:phone]
          @password              = params[:password]
          @password_confirmation = params[:password_confirmation]
        end

        def call
          user.persisted? ? token.user : user
        end

        private

        attr_reader :email, :phone, :password, :password_confirmation

        def user
          @user ||= User.create(
            password:              password,
            password_confirmation: password_confirmation,
            identities_attributes: [
              identity_attributes
            ]
          )
        end

        def identity_attributes
          return { uid: email, provider: :email } if email

          return { uid: phone, provider: :phone } if phone
        end

        def token
          @token ||= user.tokens.create(
            key:        SecureRandom.base64(18),
            key_type:   :auth,
            expired_at: Time.zone.now + 1.month
          )
        end
      end
    end
  end
end
