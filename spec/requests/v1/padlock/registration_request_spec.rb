require 'rails_helper'

describe V1::Padlock::RegistrationController, type: :request do
  describe '#create' do
    before { allow_any_instance_of(ExpireTokenJob).to receive(:perform_now).and_return(true) }

    let(:request) { post registration_path, params: params }
    let(:params)  { { user: user_params } }

    context 'with email' do
      let(:user_params) { build(:user_params, :email) }

      context 'response' do
        before { request }

        it "returns status 'created'" do
          expect(response).to have_http_status :created
        end

        it 'returns created user' do
          expect(json_response[:id]).not_to be_nil
        end

        include_examples 'access token'
      end

      context 'behavior' do
        it 'creates new user' do
          expect{ request }.to change(User, :count).by(1)
        end

        it 'creates new identity' do
          expect{ request }.to change(Identity, :count).by(1)
        end

        it 'creates new token' do
          expect{ request }.to change(Token, :count).by(1)
        end
      end

      context 'without provider' do
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

          it 'creates no identity' do
            expect{ request }.not_to change(Identity, :count)
          end

          it 'creates no token' do
            expect{ request }.not_to change(Token, :count)
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

          it 'creates no identity' do
            expect{ request }.not_to change(Identity, :count)
          end

          it 'creates no token' do
            expect{ request }.not_to change(Token, :count)
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

          it 'creates no identity' do
            expect{ request }.not_to change(Identity, :count)
          end

          it 'creates no token' do
            expect{ request }.not_to change(Token, :count)
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

          it 'creates no identity' do
            expect{ request }.not_to change(Identity, :count)
          end

          it 'creates no token' do
            expect{ request }.not_to change(Token, :count)
          end
        end
      end
    end

    context 'with phone number' do
      let(:user_params) { build(:user_params, :phone) }

      context 'response' do
        before { request }

        it "returns status 'created'" do
          expect(response).to have_http_status :created
        end

        it 'returns created user' do
          expect(json_response[:id]).not_to be_nil
        end

        include_examples 'access token'
      end

      context 'behavior' do
        it 'creates new user' do
          expect{ request }.to change(User, :count).by(1)
        end

        it 'creates new identity' do
          expect{ request }.to change(Identity, :count).by(1)
        end

        it 'creates new token' do
          expect{ request }.to change(Token, :count).by(1)
        end
      end

      context 'without provider' do
        let(:params) { { user: user_params.merge(phone: '') } }

        context 'response' do
          before { request }

          include_examples 'unprocessable entity status'
          include_examples 'no access token'
        end

        context 'behavior' do
          it 'creates no user' do
            expect{ request }.not_to change(User, :count)
          end

          it 'creates no identity' do
            expect{ request }.not_to change(Identity, :count)
          end

          it 'creates no token' do
            expect{ request }.not_to change(Token, :count)
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

          it 'creates no identity' do
            expect{ request }.not_to change(Identity, :count)
          end

          it 'creates no token' do
            expect{ request }.not_to change(Token, :count)
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

          it 'creates no identity' do
            expect{ request }.not_to change(Identity, :count)
          end

          it 'creates no token' do
            expect{ request }.not_to change(Token, :count)
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

          it 'creates no identity' do
            expect{ request }.not_to change(Identity, :count)
          end

          it 'creates no token' do
            expect{ request }.not_to change(Token, :count)
          end
        end
      end
    end
  end
end
