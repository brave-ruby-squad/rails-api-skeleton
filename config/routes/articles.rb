module Routes
  module Articles
    def call
      resources :articles, only: %i[index show update]
    end
  end
end
