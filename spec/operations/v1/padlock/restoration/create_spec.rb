require 'rails_helper'

describe V1::Padlock::Restoration::Create do
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

    it 'calls Restoration Mailer' do
      expect(V1::Padlock::RestorationMailer)
        .to receive(:restoration_email)
        .and_return(double(V1::Padlock::RestorationMailer, deliver: true))

      subject
    end
  end

  context 'phone' do
  end
end
