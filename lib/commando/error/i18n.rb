module Commando
  module Error
    module I18n
      def full_messages
        map { |attribute, message| full_message(attribute, message) }
      end

      def full_message(attribute, message)
        return message if attribute == :base

        i18n_decorator(attribute, message).full_message
      end

      def full_messages_for(attribute)
        fetch(attribute, []).map { |message| full_message(attribute, message) }
      end

      private

      delegate :i18n_path, to: :base

      def i18n_decorator(attribute, message)
        I18nDecorator.new(
          attribute: attribute,
          message:   message,
          i18n_path: i18n_path
        )
      end
    end
  end
end
