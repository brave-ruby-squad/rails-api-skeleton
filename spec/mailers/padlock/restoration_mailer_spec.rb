require 'rails_helper'

describe V1::Padlock::RestorationMailer, type: :mailer do
  let(:mail)   { described_class.restoration_email(params) }
  let(:params) { { user_id: user.id, token_key: token.key } }
  let(:user)   { create(:user, :email, :restoration_token) }
  let(:token)  { user.tokens.first }

  context 'whith token' do
    it 'renders the subject' do
      expect(mail.subject).to eq('Restore your password')
    end

    it 'renders the receiver email' do
      expect(mail.to).to eq([user.identities.first.uid])
    end

    it 'renders the body with token' do
      expect(mail.body.encoded).to match('Restore my password')
    end

    it 'contains verification URL' do
      expect { restoration_url }.not_to raise_error
    end
  end

  context 'without a token' do
    let(:params) { { user_id: user.id } }

    it "doesn't render the body" do
      expect(mail.body).to be_empty
    end
  end
end
