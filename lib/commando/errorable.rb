module Commando
  module Errorable
    delegate :i18n_path, to: :class

    def self.included(base)
      base.extend(ClassMethods)
    end

    def errors
      @errors ||= Commando::Error::Collection.new(base: self)
    end

    private

    def build_errors
      errors.merge(result.errors.messages) if result.respond_to?(:errors)
    end

    module ClassMethods
      def i18n_path
        name.gsub('::', '.').downcase
      end
    end
  end
end
