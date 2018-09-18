module Routes
  module V1
    module Users
      def call
        resources :articles, only: %i[show]
      end
    end
  end
end
