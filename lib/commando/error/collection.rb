module Commando
  module Error
    class Collection < Hash
      include Error::I18n

      attr_reader :base

      def initialize(base:)
        @base = base
      end

      def add(key, value, **_opts)
        self[key] = fetch(key, []).push(value).uniq
      end

      def merge(errors_hash)
        errors_hash.each do |key, values|
          Array(values).each { |value| add(key, value) }
        end
      end

      def each
        each_key { |field| self[field].each { |message| yield(field, message) } }
      end

      alias_method :<<, :merge
    end
  end
end
