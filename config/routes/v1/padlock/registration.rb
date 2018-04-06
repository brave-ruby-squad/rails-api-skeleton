module Routes
  module V1
    module Padlock
      module Registration
        def call
          resource :registration, only: %i[create], controller: :registration
        end
      end
    end
  end
end
