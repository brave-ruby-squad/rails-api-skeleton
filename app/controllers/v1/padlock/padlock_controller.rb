module V1
  module Padlock
    class PadlockController < ApplicationController
      ACCESS_TOKEN_KEY = 'X-Access-Token'.freeze

      after_action :insert_token

      skip_after_action :verify_authorized

      private

      attr_reader :user

      def user_valid?
        user&.persisted?
      end

      def insert_token
        response.headers[ACCESS_TOKEN_KEY] = user.tokens.last.key if user_valid?
      end

      def token
        @token ||= Token.find_by(key: request.headers[ACCESS_TOKEN_KEY])
      end
    end
  end
end
