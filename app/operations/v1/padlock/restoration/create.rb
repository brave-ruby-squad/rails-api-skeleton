module V1
  module Padlock
    module Restoration
      class Create < ::Callable
        delegate :restoration_email, to: V1::Padlock::RestorationMailer

        def initialize(params = {})
          @user = params[:user]
        end

        def call
          return if user&.new_record?

          send_email
        end

        private

        attr_reader :user

        def token
          @token ||= ::Padlock::TokenGenerator.call(
            user_id:  user.id,
            key_type: :restoration
          )
        end

        def send_email
          restoration_email(user_id: user.id, token_key: token.key).deliver
        end
      end
    end
  end
end
