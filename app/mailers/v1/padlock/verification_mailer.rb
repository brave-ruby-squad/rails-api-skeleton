module V1
  module Padlock
    class VerificationMailer < ApplicationMailer
      def verification_email(params = {})
        @user_id = params[:user_id]
        @token   = params[:token]

        return unless user && @token

        mail(to: email, subject: t('padlock.mailers.verification_mailer.verify_email'))
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
