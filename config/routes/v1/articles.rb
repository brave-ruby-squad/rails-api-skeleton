module Routes
  module V1
    module Articles
      def call
        resources :articles, only: %i[index]
      end
    end
  end
end
