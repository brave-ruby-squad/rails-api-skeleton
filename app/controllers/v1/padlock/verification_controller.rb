module V1
  module Padlock
    class VerificationController < V1::Padlock::PadlockController
      skip_after_action :insert_token

      def create
        return head :not_found unless user

        return head :ok if V1::Padlock::Verification::Create.call(user: user)

        head :unprocessable_entity
      end

      def update
        return head :not_found unless user

        V1::Padlock::Verification::Update.call(user: user, token: params[:token])

        head :ok
      end
    end
  end
end
