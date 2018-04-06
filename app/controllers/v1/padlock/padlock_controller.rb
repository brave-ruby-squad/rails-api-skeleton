module V1
  module Padlock
    class PadlockController < ApplicationController
      skip_after_action :verify_authorized

      # skip_before_action :authenticate_user

      # after_action :insert_token

      # private

      # def insert_token
      #   response.headers['X-Access-Token'] = token
      # end

      # def token
      #   @token ||= ::Padlock::Authenticator.call(sanitized_params)
      # end

      # def sanitized_params
      #   params.require(:user).permit(:name, :email, :password, :password_confirmation)
      # end
    end
  end
end
