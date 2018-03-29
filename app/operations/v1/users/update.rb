module V1
  module Users
    class Update < ::Callable
      def initialize(params = {})
        @user       = params[:user]
        @attributes = params[:attributes]
      end

      def call
        user&.update(attributes)
      end

      private

      attr_reader :user, :attributes
    end
  end
end
