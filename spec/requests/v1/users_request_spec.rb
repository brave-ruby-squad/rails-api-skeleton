require 'rails_helper'

RSpec.describe V1::UsersController, type: :request do
   describe 'GET #index' do
    before do
      create_list(:user, 5)

      get users_path
    end

    include_examples 'success status'
  end

  describe 'GET #show' do
    before do
      stub_auth!

      get user_path user
    end

    let(:user) { create(:user) }

    include_examples 'success status'
  end

  describe "PUT #update" do
    let!(:user)          { create(:user) }
    let(:new_attributes) { attributes_for(:user) }

    context 'with valid token' do
      before do
        stub_auth!

        put user_path user, params: { user: new_attributes }
      end

      include_examples 'success status'

      it 'returns updated user' do
        expect(json_response[:name]).to  eq(new_attributes[:name])
        expect(json_response[:email]).to eq(new_attributes[:email])
      end
    end

    context 'without a valid token' do
      before { put user_path user, params: { user: new_attributes } }

      it 'renders a JSON response with errors' do
        expect(response).to have_http_status(:unauthorized)
      end
    end
  end

  describe 'DELETE #destroy' do
    before { stub_auth! }

    let!(:user) { create(:user) }

    it 'destroys the requested user' do
      expect {
        delete user_path user
      }.to change(User, :count).by(-1)
    end
  end

end
