module Routes
  module V1
    module Padlock
      module Registration
        def call
          resources :registration, only: %i[create]
        end
      end
    end
  end
end
