require 'rails_helper'

RSpec.describe Padlock::Authenticator do
  subject { described_class.call(credentials) }
  let(:params) { { email: Faker::Internet.email, password: SecureRandom.base64(6) } }

  before { create(:user, params) }

  context 'when proper credentials are provided' do
    let(:credentials) { params }

    it 'returns JWT token' do
      expect(subject).not_to be_falsy
    end
  end

  context 'with invalid credentials' do
    let(:credentials) { { email: Faker::Internet.email, password: SecureRandom.base64(6) } }

    it 'returns no token' do
      expect(subject).to be_falsy
    end
  end
end
