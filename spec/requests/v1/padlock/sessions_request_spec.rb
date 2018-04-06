require 'rails_helper'

describe V1::Padlock::SessionsController, type: :request do
  describe '#create' do
    let(:request) { post sessions_path, params: params }

    context 'email' do
      let!(:user)  { create(:user, :email) }
      let(:params) { { email: user.identities.first.uid, password: user.password} }

      context 'with proper credentials' do
        context 'response' do
          before { request }

          include_examples 'success status'
          include_examples 'access token'

          it 'returns user' do
            expect(json_response[:name]).to eq(user.name)
          end
        end

        context 'behavior' do
          it 'creates a new token' do
            expect{ request }.to change(Token, :count).by(1)
          end
        end
      end

      context 'with invalid password' do
        let(:params) { { email: user.identities.first.uid, password: SecureRandom.base64(8)} }

        context 'response' do
          before { request }

          it "returns status 'unauthorized'" do
            expect(response).to have_http_status(:unauthorized)
          end

          include_examples 'no access token'
        end

        context 'behavior' do
          it "doesn't create a new token" do
            expect{ request }.not_to change(Token, :count)
          end
        end
      end
    end

    context 'phone' do
      let!(:user)  { create(:user, :phone) }
      let(:params) { { phone: user.identities.first.uid, password: user.password} }

      context 'with proper credentials' do
        context 'response' do
          before { request }

          include_examples 'success status'
          include_examples 'access token'
        end

        context 'behavior' do
          it 'creates a new token' do
            expect{ request }.to change(Token, :count).by(1)
          end
        end
      end

      context 'with invalid password' do
        let(:params) { { phone: user.identities.first.uid, password: SecureRandom.base64(8)} }

        context 'response' do
          before { request }

          it "returns status 'unauthorized'" do
            expect(response).to have_http_status(:unauthorized)
          end

          include_examples 'no access token'
        end

        context 'behavior' do
          it "doesn't create a new token" do
            expect{ request }.not_to change(Token, :count)
          end
        end
      end
    end

    context 'when there is no user' do
      let(:params) { { email: Faker::Internet.email, password: SecureRandom.base64(8)} }

      context 'response' do
        before { request }

        it "returns status 'unauthorized'" do
          expect(response).to have_http_status(:unauthorized)
        end

        include_examples 'no access token'
      end

      context 'behavior' do
        it "doesn't create a new token" do
          expect{ request }.not_to change(Token, :count)
        end
      end
    end
  end
end
