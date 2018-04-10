module V1
  class ArticlesController < ApplicationController
    decorates_assigned :articles

    before_action :fake_user

    def index
      authorize Article
      
      @presenter = Articles::Index.call(user: current_user, **id_params)
    end

    def create
      authorize Article

      @form = Articles::Create.call(article_params)

      return head :unprocessable_entity unless @form.success?

      render 'articles/show'
    end

    private

    def fake_user
      @current_user = 'kek'
    end

    def article_params
      params.require(:article).permit(:title, :body)
    end

    def id_params
      params.permit(:left_id, :right_id).deep_symbolize_keys
    end
  end
end
