module V1
  module Padlock
    class SessionController < V1::Padlock::PadlockController
      def create
        @user = V1::Padlock::Session::Create.call(params)

        return head :unauthorized unless user_persisted?

        render '/v1/users/show'
      end

      def destroy
        ::Padlock::TokenDestroyer.call(token: token) if token

        head :no_content
      end
    end
  end
end
