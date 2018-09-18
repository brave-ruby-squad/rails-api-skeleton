module Routes
  module V1
    module Padlock
      module Verification
        def call
          resource :verification, only: %i[create update], controller: :verification
        end
      end
    end
  end
end
