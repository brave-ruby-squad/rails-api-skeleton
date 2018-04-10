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
          generate_token if user.persisted?

          user
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

        def generate_token
          ::Padlock::TokenGenerator.call(user: user)
        end
      end
    end
  end
end
