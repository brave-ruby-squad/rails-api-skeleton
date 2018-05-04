module V1
  module Padlock
    class RestorationMailer < ApplicationMailer
      def restoration_email(params = {})
        @user_id   = params[:user_id]
        @token_key = params[:token_key]

        return unless user && @token_key

        mail(to: email, subject: t('padlock.mailers.restoration_mailer.restore_password'))
      end

      private

      attr_reader :user_id

      def user
        @user ||= User.find_by(id: user_id)
      end

      def email
        user.identities.first.uid
      end
    end
  end
end
