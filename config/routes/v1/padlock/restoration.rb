module Routes
  module V1
    module Padlock
      module Restoration
        def call
          resource :restoration, only: %i[create update], controller: :restoration
        end
      end
    end
  end
end
