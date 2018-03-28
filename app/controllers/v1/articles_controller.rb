module V1
  class ArticlesController < ApplicationController
    def index
      authorize Article

      @articles = Article.all
    end
  end
end
