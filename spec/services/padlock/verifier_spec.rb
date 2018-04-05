require 'rails_helper'

RSpec.describe Padlock::Verifier do
  subject { described_class.call(headers) }

  let(:user)    { create(:user) }
  let(:headers) { HashWithIndifferentAccess.new({ 'X-Access-Token': SecureRandom.base64(10) }) }

  context 'with valid headers' do
    before do
      allow_any_instance_of(JwToken::Decrypt)
        .to receive(:call)
        .and_return({ user_id: user.id })
    end

    it 'returns correct user' do
      expect(subject).to eq(user)
    end
  end

  context 'with invalid headers' do
    it 'returns nil' do
      expect(subject).to be_nil
    end
  end
end
