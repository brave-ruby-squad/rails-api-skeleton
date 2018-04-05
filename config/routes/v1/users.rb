module Routes
  module V1
    module Users
      def call
        resources :users, except: %i[create]
      end
    end
  end
end
