module V1
  module Padlock
    class SessionsController < V1::Padlock::PadlockController
      def create
        @user  = V1::Padlock::Sessions::Create.call(params)

        return render json: nil, status: :unauthorized unless @user

        response.headers['X-Access-Token'] = @user.tokens.last.key
        render '/v1/users/show', status: :ok
      end
    end
  end
end
