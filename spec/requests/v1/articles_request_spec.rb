require 'rails_helper'

describe V1::ArticlesController, type: :request do
  describe 'GET #index' do
    before { get articles_path }

    it { expect(response).to be_success }
  end
 end
