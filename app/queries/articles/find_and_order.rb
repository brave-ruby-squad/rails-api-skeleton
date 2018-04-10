module Articles
  class FindAndOrder < ApplicationQuery
    def initialize(left_id:, right_id:)
      @left_id  = left_id
      @right_id = right_id
    end

    def call
      ReverseOrder.call(scope: found_entries)
    end

    def found_entries
      Find.call(left_id: left_id, right_id: right_id)
    end

    private

    attr_reader :left_id, :right_id
  end
end
