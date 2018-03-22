module V1
  class ArticlesController < ApplicationController
    def index
      @articles = Article.all
    end
  end
end
