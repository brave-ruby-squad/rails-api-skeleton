require 'rails_helper'

describe V1::Padlock::Sessions::Create do
  subject { described_class.call(params) }

  context 'email' do
    let!(:user)  { create(:user, :email) }
    let(:params) { { email: user.identities.first.uid, password: user.password} }

    it 'finds proper identity' do
      expect(subject.identities.first.uid).to eq(params[:email])
    end

    it 'returns authenticated user' do
      expect(subject).to be_a User
    end

    it 'creates new token' do
      expect{ subject }.to change(Token, :count).by(1)
    end

    context 'when proper credentials are not provided' do
      let(:params) { { email: user.identities.first.uid, password: SecureRandom.base64(8) } }

      it 'returns nil' do
        expect(subject).to be_nil
      end

      it "doesn't create new token" do
        expect{ subject }.not_to change(Token, :count)
      end
    end
  end

  context 'phone' do
    let!(:user)  { create(:user, :phone) }
    let(:params) { { phone: user.identities.first.uid, password: user.password} }

    it 'finds proper identity' do
      expect(subject.identities.first.uid).to eq(params[:phone])
    end

    it 'returns authenticated user' do
      expect(subject).to be_a User
    end

    it 'creates new token' do
      expect{ subject }.to change(Token, :count).by(1)
    end

    context 'when proper credentials are not provided' do
      let(:params) { { phone: user.identities.first.uid, password: SecureRandom.base64(8)} }

      it 'returns nil' do
        expect(subject).to be_nil
      end

      it "doesn't create new token" do
        expect{ subject }.not_to change(Token, :count)
      end
    end
  end

  context 'when user is not registered' do
    let(:params) { { email: Faker::Internet.email, password: SecureRandom.base64(8)} }

    it 'returns nil' do
      expect(subject).to be_nil
    end

    it "doesn't create new token" do
      expect{ subject }.not_to change(Token, :count)
    end
  end
end
