module V1
  module Padlock
    class RegistrationController < V1::Padlock::PadlockController
      def create
        @user = ::Padlock::Registrator.call(sanitized_params)

        return render json: @user.errors, status: :unprocessable_entity unless @user.persisted?

        render 'v1/users/show', status: :created, location: @user
      end
    end
  end
end
