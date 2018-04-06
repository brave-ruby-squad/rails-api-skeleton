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

          create_token

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

        def create_token
          user.tokens.create(
            key:        SecureRandom.base64(18),
            key_type:   :auth,
            expired_at: Time.zone.now + 1.month
          )
        end
      end
    end
  end
end
