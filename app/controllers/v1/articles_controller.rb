module V1
  class ArticlesController < ApplicationController
    decorates_assigned :articles

    def index
      authorize Article

      @articles = Article
        .page(params[:page])
        .per(params[:per_page])
    end
  end
end
