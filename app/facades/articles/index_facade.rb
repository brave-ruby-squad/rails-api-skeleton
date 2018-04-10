module Articles
  class IndexFacade
    attr_reader :user

    def initialize(user:, **params)
      @user     = user
      @left_id  = params[:left_id]
      @right_id = params[:right_id]
      @page     = params[:page]
      @per_page = params[:per_page]
    end

    def articles
      @articles ||= FindAndOrder
        .call(ids
        .result
        .page(page)
        .per(per_page)
        .load
    end

    private

    attr_reader :left_id, :right_id, :page, :per_page

    def ids
      {
        left_id: left_id,
        right_id: right_id
      }
    end
  end
end
