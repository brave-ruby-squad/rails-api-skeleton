require 'rails_helper'

describe V1::Padlock::Verification::Update do
  let(:params) { { user: user, token: token.key } }
  let(:user)   { create(:user, :verification_token) }
  let(:token)  { user.tokens.first }

  context 'email' do
    it 'calls user update' do
      expect(user).to receive(:update)

      described_class.call(params)
    end

    it 'destroys verification token' do
      expect(::Padlock::TokenDestroyer).to receive(:call)

      described_class.call(params)
    end

    context 'when user is already verified' do
      let(:user) { create(:user, :verified, :verification_token) }

      it "doesn't call user update" do
        expect(user).not_to receive(:update)

        described_class.call(params)
      end
    end
  end

  context 'phone' do
  end
end
