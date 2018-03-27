module Routes
  module V2
    module Admin
      module Articles
        def call
          resources :articles, only: %i[show destroy]
        end
      end
    end
  end
end
