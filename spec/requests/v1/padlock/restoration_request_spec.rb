require 'rails_helper'

describe V1::Padlock::RestorationController, type: :request do
  describe '#create' do
    let(:request) { post restoration_path }

    context 'email' do
      let!(:user) { create(:user, :email) }

      context 'with existing user' do
        before do
          allow_any_instance_of(::Padlock::UserByToken)
            .to receive(:call)
            .and_return(user)

          expect(V1::Padlock::RestorationMailer)
            .to receive(:restoration_email)
            .and_return(double(V1::Padlock::RestorationMailer, deliver: true))
        end

        context 'response' do
          before { request }

          include_examples 'success status'
        end

        context 'behavior' do
          it 'creates new validation token' do
            expect{ request }.to change(Token, :count).by(1)
          end
        end
      end

      context 'without a user' do
        before do
          expect(V1::Padlock::VerificationMailer)
            .not_to receive(:verification_email)
        end

        context 'response' do
          before { request }

          it "return status 'not found'" do
            expect(response).to have_http_status(:not_found)
          end
        end

        context 'behavior' do
          it "doesn't create validation token" do
            expect{ request }.not_to change(Token, :count)
          end
        end
      end
    end

    context 'phone' do
    end
  end

  describe 'update' do
    let(:request)     { patch restoration_path params: params }
    let(:params)      { { user: user_params, token: token.key } }
    let(:user_params) { build(:user_params) }

    context 'email' do
      let!(:user)   { create(:user, :email, :restoration_token) }
      let(:token)   { user.tokens.first }

      context 'with valid token' do
        before do
          allow_any_instance_of(::Padlock::UserByToken)
            .to receive(:call)
            .and_return(user)

          # allow_any_instance_of(V1::Padlock::RestorationController)
          #   .to receive(:params)
          #   .and_return({ token: token.key })
        end

        context 'response' do
          before { request }

          include_examples 'success status'
        end

        context 'behavior' do
          it "changes 'password' field" do
            expect{ request }.to change(user, :password)
          end

          it 'destroys restoration token' do
            expect{ request }.to change(Token, :count).by(-1)
          end
        end

        context 'when password confirmation does not match' do

        end
      end

      context 'with invalid token' do
        before { request }

        it "return status 'not found'" do
          expect(response).to have_http_status(:not_found)
        end
      end
    end

    context 'phone' do
    end
  end
end
