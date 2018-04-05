module V1
  module Padlock
    class AuthenticationController < V1::Padlock::PadlockController
      def create
        return unauthorized! unless token

        render json: { status: :success }
      end
    end
  end
end
