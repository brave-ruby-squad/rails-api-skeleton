module V1
  module Padlock
    class PadlockController < ApplicationController
      ACCESS_TOKEN_KEY = 'X-Access-Token'.freeze

      after_action :insert_token

      skip_after_action :verify_authorized

      protected

      def user_persisted?
        user.present? && user.persisted?
      end

      def insert_token
        return unless user_persisted?

        response.headers[ACCESS_TOKEN_KEY] =
          token || ::Padlock::TokenGenerator.call(user_id: user.id).key
      end

      def token
        @token ||= Token.find_by(key: request.headers[ACCESS_TOKEN_KEY])
      end

      def user
        @user ||= ::Padlock::UserByToken.call(token: token)
      end
    end
  end
end
