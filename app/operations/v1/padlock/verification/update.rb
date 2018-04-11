module V1
  module Padlock
    module Verification
      class Update < ::Callable
        def initialize(params = {})
          @user      = params[:user]
          @token_key = params[:token]
        end

        def call
          return if user&.new_record? || user&.verified_at

          update_user && destroy_token
        end

        private

        attr_reader :user, :token_key

        def update_user
          user.update(verified_at: Time.zone.now)
        end

        def token
          @token ||= Token.find_by(key: token_key, key_type: :verification)
        end

        def destroy_token
          ::Padlock::TokenDestroyer.call(token: token)
        end
      end
    end
  end
end
