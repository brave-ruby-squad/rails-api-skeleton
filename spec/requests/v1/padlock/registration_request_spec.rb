require "rails_helper"

RSpec.describe V1::Padlock::RegistrationController, type: :request do
  describe '#create' do
    let(:request) { post registration_index_path, params: params }

    # NOTE do I even use this shit?
    let(:password)    { SecureRandom.base64(6) }
    let(:user_params) { attributes_for(:user).merge(password: password, password_confirmation: password) }

    context 'success' do
      let(:params) { { user: user_params } }

      context 'response' do
        before { request }

        it "returns status 'created'" do
          expect(response).to have_http_status :created
        end

        it 'returns created user' do
          expect(json_response[:email]).to eq(user_params[:email])
        end

        include_examples 'access token'
      end

      context 'behavior' do
        it 'creates a new user' do
          expect{ request }.to change(User, :count).by(1)
        end
      end
    end

    context 'without email' do
      let(:params) { { user: user_params.merge(email: '') } }

      context 'response' do
        before { request }

        include_examples 'unprocessable entity status'
        include_examples 'no access token'
      end

      context 'behavior' do
        it 'creates no user' do
          expect{ request }.not_to change(User, :count)
        end
      end
    end

    context 'without password' do
      let(:params) { { user: user_params.merge(password: '') } }

      context 'response' do
        before { request }

        include_examples 'unprocessable entity status'
        include_examples 'no access token'
      end

      context 'behavior' do
        it 'creates no user' do
          expect{ request }.not_to change(User, :count)
        end
      end
    end

    context 'without password confirmation' do
      let(:params) { { user: user_params.merge(password_confirmation: '') } }

      context 'response' do
        before { request }

        include_examples 'unprocessable entity status'
        include_examples 'no access token'
      end

      context 'behavior' do
        it 'creates no user' do
          expect{ request }.not_to change(User, :count)
        end
      end
    end

    context 'when password does not match password confirmation' do
      let(:params) { { user: user_params.merge(password_confirmation: SecureRandom.base64(6)) } }

      context 'response' do
        before { request }

        include_examples 'unprocessable entity status'
        include_examples 'no access token'
      end

      context 'behavior' do
        it 'creates no user' do
          expect{ request }.not_to change(User, :count)
        end
      end

    end
  end
end
