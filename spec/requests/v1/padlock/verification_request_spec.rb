require 'rails_helper'

describe V1::Padlock::VerificationController, type: :request do
  describe '#create' do
    context 'email' do
      let(:request) { post verification_path }

      context 'with existing unverified user' do
        let!(:user) { create(:user, :email) }

        before do
          allow_any_instance_of(::Padlock::UserByToken)
            .to receive(:call)
            .and_return(user)

          expect(V1::Padlock::VerificationMailer)
            .to receive(:verification_email)
            .and_return(double(V1::Padlock::VerificationMailer, deliver: true))
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

      context 'with verified user' do
        let!(:user) { create(:user, :verified) }

        before do
          allow_any_instance_of(::Padlock::UserByToken)
            .to receive(:call)
            .and_return(user)

          request
        end

        it "doesn't call Verification::Create" do
          expect(V1::Padlock::Verification::Create).not_to receive(:call)
        end

        it "doesn't call VerificationMailer" do
          expect(V1::Padlock::VerificationMailer).not_to receive(:verification_email)
        end

        include_examples 'unprocessable entity status'
      end

      context 'without a user' do
        before { request }

        it "doesn't call Verification::Create" do
          expect(V1::Padlock::Verification::Create).not_to receive(:call)
        end

        it "doesn't call VerificationMailer" do
          expect(V1::Padlock::VerificationMailer).not_to receive(:verification_email)
        end

        it "return status 'not found'" do
          expect(response).to have_http_status(:not_found)
        end
      end
    end

    context 'phone' do
    end
  end


  describe '#update' do
    context 'email' do
      let(:request) { patch verification_path }
      let!(:user)   { create(:user, :email, :verification_token) }
      let(:token)   { user.tokens.first }

      context 'with valid token' do
        before do
          allow_any_instance_of(::Padlock::UserByToken)
            .to receive(:call)
            .and_return(user)

          allow_any_instance_of(V1::Padlock::VerificationController)
            .to receive(:params)
            .and_return({ token: token.key })
        end

        context 'response' do
          before { request }

          include_examples 'success status'
        end

        context 'behavior' do
          it "sets 'verified_at' field" do
            expect{ request }.to change(user, :verified_at)
          end

          it 'destroys verification token' do
            expect{ request }.to change(Token, :count).by(-1)
          end
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
