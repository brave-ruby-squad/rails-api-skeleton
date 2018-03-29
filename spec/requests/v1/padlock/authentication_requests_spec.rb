require "rails_helper"

RSpec.describe V1::Padlock::AuthenticationController, type: :request do
  describe '#create' do
    before { post authentication_index_path, params: params }

    let!(:user)       { create(:user) }
    let(:user_params) { { email: user.email, password: user.password} }

    context 'with success' do
      let(:params) { { user: user_params } }

      include_examples 'success status'
      include_examples 'access token'
    end

    context 'with invalid email' do
      let(:params) { { user: user_params.merge(email: Faker::Internet.email) } }

      it "returns status 'unauthorized'" do
        expect(response).to have_http_status(:unauthorized)
      end

      include_examples 'no access token'
    end

    context 'with invalid password' do
      let(:params) { { user: user_params.merge(password: SecureRandom.base64(6)) } }

      include_examples 'no access token'
    end
  end
end
