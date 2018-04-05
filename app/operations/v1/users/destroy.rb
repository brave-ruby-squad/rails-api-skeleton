module V1
  module Users
    class Destroy < ::Callable
      def initialize(params)
        @user = params[:user]
      end

      def call
        user.destroy
      end

      private

      attr_reader :user
    end
  end
end
