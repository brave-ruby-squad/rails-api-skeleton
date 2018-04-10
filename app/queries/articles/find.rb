module Articles
  class Find < ApplicationQuery
    def initialize(left_id:, right_id:)
      @left_id  = left_id
      @right_id = right_id
    end

    def call
      scope.where('id >= ? AND id <= ?', left_id, right_id)
    end

    private

    attr_reader :left_id, :right_id
  end
end
