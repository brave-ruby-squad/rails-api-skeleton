require 'rails_helper'

describe Padlock::TokenGenerator do
  subject { described_class.call(params) }

  let(:user)   { create(:user) }
  let(:params) { { user_id: user.id } }

  it 'creates new token for a user' do
    expect{ subject }.to change(user.tokens, :count).by(1)
  end

  it 'creates delayed job' do
    expect{ subject }.to change(ExpireTokenJob.jobs, :size).by(1)
  end

  describe 'auth token' do
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

  describe 'verification token' do
    let(:params) do
      {
        user_id:  user.id,
        key_type: :verification
      }
    end

    it 'generates token key' do
      expect(subject.key).not_to be_falsy
    end

    it "has 'auth' type by default" do
      expect(subject.key_type).to eq('verification')
    end

    it 'sets expiration date' do
      expect(subject.expired_at).not_to be_falsy
    end
  end

  describe 'password recovery token' do

  end
end
