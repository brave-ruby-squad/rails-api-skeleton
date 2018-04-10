module Commando
  class Base
    extend Hooks
    extend Callable

    include Status
    include Errorable
    include Trace

    attr_reader :result

    def call
      raise NotImplementedError, Constants::NOT_IMPLEMENTED_MESSAGE
    end

    private

    def called!
      super

      build_errors
    end
  end
end
