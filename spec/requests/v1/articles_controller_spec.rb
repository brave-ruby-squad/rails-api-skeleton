require 'rails_helper'

describe V1::ArticlesController, type: :request do
  let(:valid_attributes) do
    {
      title: 'Leobit',
      body:  'Ruby API Skeleton'
    }
  end

  describe 'GET #index' do
    let!(:article) { Article.create(valid_attributes) }

    it 'returns a success response' do
      get articles_path
      expect(response).to be_success
    end
  end
end
