module Routes
  module V1
    module Padlock
      module Authentication
        def call
          resources :authentication, only: %i[create]
        end
      end
    end
  end
end
