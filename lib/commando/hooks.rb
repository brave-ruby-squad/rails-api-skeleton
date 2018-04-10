module Commando
  module Hooks
    def run_before(*methods, **conditions)
      assign_callback(methods, conditions) do |name, method_list|
        Module.new do
          define_method(name) do |*args, &block|
            method_list.each { |method_name| send(method_name) }

            @result = super(*args, &block)
          end
        end
      end
    end

    def run_after(*methods, **conditions)
      assign_callback(methods, conditions) do |name, method_list|
        Module.new do
          define_method(name) do |*args, &block|
            @result = super(*args, &block)

            method_list.each { |method_name| send(method_name) }
          end
        end
      end
    end

    private

    def assign_callback(method_list, conditions)
      callbacks = yield(:call, method_list, conditions)

      prepend(callbacks)
    end
  end
end
