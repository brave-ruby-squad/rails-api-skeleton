module V1
  module Padlock
    class SessionController < V1::Padlock::PadlockController
      def create
        @user = V1::Padlock::Sessions::Create.call(params)

        return render json: nil, status: :unauthorized unless @user

        render '/v1/users/show', status: :ok
      end

      def destroy
        return render json: nil, status: :unprocessable_entity unless token

        return render json: nil, head: :ok if ::Padlock::TokenDestroyer.call(token: token)
      end
    end
  end
end
