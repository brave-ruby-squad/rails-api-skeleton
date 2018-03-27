module Routes
  module Articles
    def call
      resources :articles, only: %i[show]
    end
  end
end
