module V1
  module Padlock
    module Sessions
      class Create < ::Callable
        def initialize(params = {})
          @password = params[:password]
          @email    = params[:email]
          @phone    = params[:phone]
        end

        def call
          return unless identity && user.authenticate(password)

          generate_token

          user
        end

        private

        attr_reader :password, :email, :phone

        def identity
          @identity ||= case
                        when email
                          Identity.find_by(uid: email)
                        when phone
                          Identity.find_by(uid: phone)
                        end
        end

        def user
          @user ||= User.find_by(id: identity.user_id)
        end

        def generate_token
          ::Padlock::TokenGenerator.call(user: user)
        end
      end
    end
  end
end
