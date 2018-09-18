require 'rails_helper'

describe Padlock::UserByToken do
  subject { described_class.call(token: token.key) }

  context 'with valid token' do
    let(:token) { create(:token) }

    it 'returns token owner' do
      expect(subject.tokens.first).to eq(token)
    end

    it 'returns a user' do
      expect(subject).to be_a(User)
    end
  end

  context 'with invalid token' do
    let(:token) { build(:token) }

    it 'returns nil' do
      expect(subject).to be_nil
    end
  end
end
