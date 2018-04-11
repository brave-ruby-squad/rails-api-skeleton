module V1
  module Padlock
    module Verification
      class Create < ::Callable
        delegate :verification_email, to: V1::Padlock::VerificationMailer

        def initialize(params = {})
          @user = params[:user]
        end

        def call
          return if user&.new_record? || user&.verified_at

          send_email
        end

        private

        attr_reader :user

        def token
          @token ||= ::Padlock::TokenGenerator.call(
            user_id:  user.id,
            key_type: :verification
          )
        end

        def send_email
          verification_email(user_id: user.id, token: token).deliver
        end
      end
    end
  end
end
