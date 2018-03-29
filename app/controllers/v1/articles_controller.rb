module V1
  class ArticlesController < ApplicationController
    decorates_assigned :articles

    def index
      authorize Article

      @articles = Article.all
    end
  end
end
