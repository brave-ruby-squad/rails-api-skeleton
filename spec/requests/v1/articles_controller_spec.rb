require 'rails_helper'

describe V1::ArticlesController, type: :request do
  let(:user) { Faker::Superhero.name }

  describe 'GET #index' do
    before { get articles_path, params: params }

    context 'response and data' do
      let!(:articles)      { create_list(:article, 5) }
      let(:left_id)        { articles.first.id }
      let(:right_id)       { articles.third.id }
      let(:articles_count) { right_id - left_id + 1 }

      let(:params) { { left_id: left_id, right_id: right_id } }

      it { expect(response).to                        be_success }
      it { expect(json_response[:articles].length).to eq(articles_count) }
    end

    context 'fields' do
      let!(:article) { create(:article) }

      let(:params) { { left_id: article.id, right_id: article.id } }

      it { expect(json_response[:user]).to            eq(user) }
      it { expect(json_response[:articles].length).to eq(articles_count) }

      context 'articles' do
        let(:article_response) { json_response[:articles].first }

        it { expect(article_response[:id]).not_to be_nil }
        it { expect(article_response[:title]).to  eq(article.title) }
        it { expect(article_response[:body]).to   eq(article.body) }
      end
    end
  end

  describe 'POST #create' do
    let(:article_params) { attributes_for(:article).slice(:title, :body) }
    let(:request)        { post articles_path, params: params }

    context 'valid' do
      let(:params) { { article: article_params, user: user } }

      it { expect{ request }.to change(Article, :count).by(1) }

      context 'response' do
        before { request }

        it { expect(response).to be_success }

        context 'fields' do
          it { expect(json_response[:id]).not_to be_nil }
          it { expect(json_response[:title]).to  eq(article_params[:title]) }
          it { expect(json_response[:body]).to   eq(article_params[:body]) }
        end
      end
    end

    context 'invalid' do
      let!(:article) { create(:article, article_params) }
      let(:params)   { { article: article_params, user: user } }

      it { expect{ request }.not_to change(Article, :count) }

      context 'response' do
        before { request }

        it { expect(response).to have_http_status(:unprocessable_entity) }
        it { expect(response).to be_empty }
      end
    end
  end
end
