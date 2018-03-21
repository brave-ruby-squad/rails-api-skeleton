module ActionDispatch
  module Routing
    class Mapper
      class Scope
        def namespace
          @hash
            .fetch(:module, '')
            .to_s
            .split('/')
            .map(&:camelize)
            .join('::')
        end
      end
    end
  end
end
