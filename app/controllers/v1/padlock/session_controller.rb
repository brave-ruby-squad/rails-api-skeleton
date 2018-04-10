module V1
  module Padlock
    class SessionController < V1::Padlock::PadlockController
      def create
        @user = V1::Padlock::Sessions::Create.call(params)

        return head :unauthorized unless @user

        render '/v1/users/show', status: :ok
      end

      def destroy
        return head :unprocessable_entity unless token

        return head :ok if ::Padlock::TokenDestroyer.call(token: token)
      end
    end
  end
end
