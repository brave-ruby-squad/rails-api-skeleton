require 'rails_helper'

describe V1::Padlock::VerificationMailer, type: :mailer do
  let(:mail)   { V1::Padlock::VerificationMailer.verification_email(params) }
  let(:params) { { user_id: user.id, token: token } }
  let(:token)  { SecureRandom.base64(8) }
  let(:user)   { create(:user, :email) }

  context 'whith token' do
    it 'renders the subject' do
      expect(mail.subject).to eq('Verify your email address')
    end

    it 'renders the receiver email' do
      expect(mail.to).to      eq([user.identities.first.uid])
    end

    it 'renders the body with token' do
      expect(mail.body.encoded).to match('Verify my email')
    end

    it 'contains verification URL' do
      expect { verification_url }.not_to raise_error
    end
  end

  context 'without a token' do
    let(:token) { nil }

    it "doesn't render the body" do
      expect(mail.body).to be_empty
    end
  end
end
