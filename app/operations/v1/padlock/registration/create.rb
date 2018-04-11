module V1
  module Padlock
    module Registration
      class Create < ::Callable
        def initialize(params = {})
          @email                 = params[:email]
          @phone                 = params[:phone]
          @password              = params[:password]
          @password_confirmation = params[:password_confirmation]
        end

        def call
          User.create(
            password:              password,
            password_confirmation: password_confirmation,
            identities_attributes: identities_attributes
          )
        end

        private

        attr_reader :email, :phone, :password, :password_confirmation

        def identities_attributes
          Array[identity_attributes].compact
        end

        def identity_attributes
          return { uid: email, provider: :email } if email
          return { uid: phone, provider: :phone } if phone
        end
      end
    end
  end
end
