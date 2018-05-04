require 'rails_helper'

describe V1::Padlock::Verification::Create do
  subject { described_class.call(params) }

  let(:params) { { user: user } }
  let(:user)   { create(:user, :email) }

  context 'email' do
    it 'calls Token Generator' do
      expect(::Padlock::TokenGenerator)
        .to receive(:call)
        .and_return(create(:token))

      subject
    end

    it 'calls Verification Mailer' do
      expect(V1::Padlock::VerificationMailer)
        .to receive(:verification_email)
        .and_return(double(V1::Padlock::VerificationMailer, deliver: true))

      subject
    end
  end

  context 'when the user is already verified' do
    let(:user) { create(:user, :verified) }

    it "doesn't call Token Generator" do
      expect(::Padlock::TokenGenerator).not_to receive(:call)

      subject
    end

    it "doesn't call Verification Mailer" do
      expect(V1::Padlock::VerificationMailer).not_to receive(:verification_email)

      subject
    end
  end
end
