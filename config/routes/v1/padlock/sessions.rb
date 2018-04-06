module Routes
  module V1
    module Padlock
      module Sessions
        def call
          resources :sessions, only: %i[create destroy]
        end
      end
    end
  end
end
