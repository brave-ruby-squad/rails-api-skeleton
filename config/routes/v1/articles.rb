module Routes
  module V1
    module Articles
      def call
        resources :articles, only: %i[index create]
      end
    end
  end
end
