module Routes
  module V1
    module Padlock
      module Session
        def call
          resource :session, only: %i[create destroy], controller: :session
        end
      end
    end
  end
end
