module V1
  module Padlock
    module Session
      class Create < ::Callable
        def initialize(params = {})
          @password = params[:password]
          @email    = params[:email]
          @phone    = params[:phone]
        end

        def call
          return unless identity && user.authenticate(password)

          user
        end

        private

        attr_reader :password, :email, :phone

        def identity
          @identity ||= Identity.find_by(uid: uid)
        end

        def uid
          email || phone
        end

        def user
          @user ||= User.find_by(id: identity.user_id)
        end
      end
    end
  end
end
