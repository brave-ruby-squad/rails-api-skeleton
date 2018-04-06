module Routes
  module V1
    module Padlock
      module Registrations
        def call
          resources :registrations, only: %i[create]
        end
      end
    end
  end
end
