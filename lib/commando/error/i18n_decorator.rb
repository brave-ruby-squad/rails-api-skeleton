module Commando
  module Error
    class I18nDecorator
      attr_reader :message, :i18n_path

      def initialize(attribute:, message:, i18n_path:)
        @attribute = attribute
        @message   = message
        @i18n_path = i18n_path
      end

      def attribute
        ::I18n.t(
          "errors.commands.#{i18n_path}.#{@attribute}",
          default: default_attribute_name
        )
      end

      def full_message
        ::I18n.t(
          Constants::DEFAULT_ERROR_FORMAT_PATH,
          default:   pattern,
          attribute: attribute,
          message:   message
        )
      end

      private

      def pattern
        pattern_pair.reject(&:empty?).join(' ')
      end

      def pattern_pair
        Array[attribute, message]
      end

      def default_attribute_name
        @attribute.to_s.tr('.', '_').humanize
      end
    end
  end
end
