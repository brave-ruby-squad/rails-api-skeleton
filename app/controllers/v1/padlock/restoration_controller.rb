module V1
  module Padlock
    class RestorationController < V1::Padlock::PadlockController
      skip_after_action :insert_token

      def create
        return head :not_found unless user

        V1::Padlock::Restoration::Create.call(user: user)

        head :ok
      end

      def update
        return head :not_found unless user

        user.update(user_params)

        @token = Token.find_by(key: params[:token], key_type: :restoration)

        ::Padlock::TokenDestroyer.call(token: @token)

        head :ok
      end

      private

      def user_params
        params.require(:user).permit(:password, :password_confirmation)
      end
    end
  end
end
