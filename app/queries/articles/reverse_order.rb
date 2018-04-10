module Articles
  class ReverseOrder < ApplicationQuery
    def initialize(**params)
      @scope = params.fetch(:scope, scope)
    end

    def call
      scope.order(id: :desc)
    end
  end
end
