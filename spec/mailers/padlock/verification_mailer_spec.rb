require 'rails_helper'

describe V1::Padlock::VerificationMailer, type: :mailer do
  let(:mail)   { described_class.verification_email(params) }
  let(:params) { { user_id: user.id, token_key: token.key } }
  let(:token)  { user.tokens.first }
  let(:user)   { create(:user, :email, :verification_token) }

  context 'whith token' do
    it 'renders the subject' do
      expect(mail.subject).to eq('Verify your email address')
    end

    it 'renders the receiver email' do
      expect(mail.to).to eq([user.identities.first.uid])
    end

    it 'renders the body with token' do
      expect(mail.body.encoded).to match('Verify my email')
    end

    it 'contains verification URL' do
      expect { verification_url }.not_to raise_error
    end
  end

  context 'without a token' do
    let(:params) { { user_id: user.id } }

    it "doesn't render the body" do
      expect(mail.body).to be_empty
    end
  end
end
