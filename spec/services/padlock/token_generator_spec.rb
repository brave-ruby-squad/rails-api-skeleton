require 'rails_helper'

describe Padlock::TokenGenerator do
  subject { described_class.call(user: user) }

  let(:user) { create(:user) }

  it 'creates new token for a user' do
    expect{ subject }.to change(user.tokens, :count).by(1)
  end

  describe 'token' do
    it 'generates token key' do
      expect(subject.key).not_to be_falsy
    end

    it "has 'auth' type by default" do
      expect(subject.key_type).to eq('auth')
    end

    it 'sets expiration date' do
      expect(subject.expired_at).not_to be_falsy
    end
  end
end
