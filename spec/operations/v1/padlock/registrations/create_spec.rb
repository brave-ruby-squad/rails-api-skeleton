require 'rails_helper'

describe V1::Padlock::Registrations::Create do
  subject { described_class.call(params) }

  before { allow_any_instance_of(ExpireTokenJob).to receive(:perform_now).and_return(true) }

  let(:params) { user_params }

  context 'with email' do
    let(:user_params) { build(:user_params, :email) }

    it 'creates new user' do
      expect{ subject }.to change(User, :count).by(1)
    end

    it 'creates new identity' do
      expect{ subject }.to change(Identity, :count).by(1)
    end

    it 'creates new token' do
      expect{ subject }.to change(Token, :count).by(1)
    end

    it 'returns created user' do
      expect(subject).to be_a User
    end

    it 'assigns email to user identity' do
      expect(subject.identities.first.uid).to eq(params[:email])
    end

    it 'assigns email provider to user identity' do
      expect(subject.identities.first.provider).to eq('email')
    end

    it 'creates new user token' do
      expect(subject.tokens.first.key).not_to be_nil
    end

    context 'without email' do
      let(:params) { user_params.merge(email: '') }

      it 'creates new user' do
        expect{ subject }.not_to change(User, :count)
      end

      it 'creates new identity' do
        expect{ subject }.not_to change(Identity, :count)
      end

      it 'creates new token' do
        expect{ subject }.not_to change(Token, :count)
      end

      it 'returns unsaved user' do
        expect(subject).to be_a User
        expect(subject).not_to be_persisted
      end

      it 'returns user errors' do
        expect(subject.errors).to include('identities.uid')
      end

    end
  end

  context 'with phone number' do
    let(:user_params) { build(:user_params, :phone) }

    it 'creates new user' do
      expect{ subject }.to change(User, :count).by(1)
    end

    it 'creates new identity' do
      expect{ subject }.to change(Identity, :count).by(1)
    end

    it 'creates new token' do
      expect{ subject }.to change(Token, :count).by(1)
    end

    it 'returns created user' do
      expect(subject).to be_a User
    end

    it 'assigns phone to user identity' do
      expect(subject.identities.first.uid).to eq(params[:phone])
    end

    it 'assigns phone provider to user identity' do
      expect(subject.identities.first.provider).to eq('phone')
    end

    it 'creates new user token' do
      expect(subject.tokens.first.key).not_to be_nil
    end

    context 'without phone number' do
      let(:params) { user_params.merge(phone: '') }

      it 'creates new user' do
        expect{ subject }.not_to change(User, :count)
      end

      it 'creates new identity' do
        expect{ subject }.not_to change(Identity, :count)
      end

      it 'creates new token' do
        expect{ subject }.not_to change(Token, :count)
      end

      it 'returns unsaved user' do
        expect(subject).to be_a User
        expect(subject).not_to be_persisted
      end

      it 'returns user errors' do
        expect(subject.errors).to include('identities.uid')
      end
    end
  end

  context 'with invalid password' do
    let(:user_params) { build(:user_params, :email) }

    context 'with no password' do
      let(:params) { user_params.merge(password: '') }

      it "doesn't create a new user" do
        expect{ subject }.not_to change(User, :count)
      end

      it 'creates new identity' do
        expect{ subject }.not_to change(Identity, :count)
      end

      it 'creates new token' do
        expect{ subject }.not_to change(Token, :count)
      end

      it 'returns unsaved user' do
        expect(subject).not_to be_persisted
      end

      it 'returns user errors' do
        expect(subject.errors).to include('password')
      end
    end

    context 'with no password confirmation' do
      let(:params) { user_params.merge(password_confirmation: '') }

      it "doesn't create a new user" do
        expect{ subject }.not_to change(User, :count)
      end

      it 'creates new identity' do
        expect{ subject }.not_to change(Identity, :count)
      end

      it 'creates new token' do
        expect{ subject }.not_to change(Token, :count)
      end

      it 'returns unsaved user' do
        expect(subject).not_to be_persisted
      end

      it 'returns user errors' do
        expect(subject.errors).to include('password_confirmation')
      end
    end

    context 'with unmatching password confirmation' do
      let(:params) { user_params.merge(password_confirmation: SecureRandom.base64(6)) }

      it "doesn't create a new user" do
        expect{ subject }.not_to change(User, :count)
      end

      it 'creates new identity' do
        expect{ subject }.not_to change(Identity, :count)
      end

      it 'creates new token' do
        expect{ subject }.not_to change(Token, :count)
      end

      it 'returns unsaved user' do
        expect(subject).not_to be_persisted
      end

      it 'returns user errors' do
        expect(subject.errors).to include('password_confirmation')
      end
    end
  end
end
