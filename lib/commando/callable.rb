module Commando
  module Callable
    def call(*args)
      instance(*args).tap do |object|
        object.instance_variable_set(:@result, object.call)
        object.send(:called!)

        return yield(*block_args(object)) if block_given?
      end
    end

    private

    def instance(*args)
      new(*args)
    end

    def block_args(object)
      Constants::BLOCK_ARGS.map { |method_name| object.send(method_name) }
    end
  end
end
