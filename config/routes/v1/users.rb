module Routes
  module V1
    module Users
      def call
        resources :users
      end
    end
  end
end
