module V1
  module Padlock
    class RegistrationController < V1::Padlock::PadlockController
      def create
        @user = V1::Padlock::Registrations::Create.call(user_params)

        return render json: @user.errors, status: :unprocessable_entity unless @user.persisted?

        render '/v1/users/show', status: :created
      end

      private

      def user_params
        params.require(:user).permit(:email, :phone, :password, :password_confirmation)
      end
    end
  end
end
