require 'rails_helper'

RSpec.describe Padlock::Registrator do
  subject { described_class.call(params) }

  let(:password) { SecureRandom.base64(8) }

  context 'with proper params' do
    let(:params) { attributes_for(:user).except(:name) }

    it 'creates a new user' do
      expect{
        subject
      }.to change(User, :count).by(1)
    end

    it 'assigns user email' do
      expect(subject.email).to eq(params[:email])
    end
  end

  context 'with invalid params' do
    context 'with no email' do
      let(:params) { attributes_for(:user).except(:name, :email) }

      it "doesn't create a new user" do
        expect{
          subject
        }.not_to change(User, :count)
      end

      it 'returns unsaved user' do
        expect(subject).not_to be_persisted
      end

      it 'returns user errors' do
        expect(subject.errors).to include('email')
      end
    end

    context 'with no password' do
      let(:params) { attributes_for(:user).except(:name, :password) }

      it "doesn't create a new user" do
        expect{
          subject
        }.not_to change(User, :count)
      end

      it 'returns unsaved user' do
        expect(subject).not_to be_persisted
      end

      it 'returns user errors' do
        expect(subject.errors).to include('password')
      end
    end

    context 'with no password confirmation' do
      let(:params) { attributes_for(:user).except(:name, :password_confirmation) }

      it "doesn't create a new user" do
        expect{
          subject
        }.not_to change(User, :count)
      end

      it 'returns unsaved user' do
        expect(subject).not_to be_persisted
      end

      it 'returns user errors' do
        expect(subject.errors).to include('password_confirmation')
      end
   end

    context 'with unmatching password confirmation' do
      let(:params) { attributes_for(:user).except(:name).merge(password_confirmation: SecureRandom.base64(6)) }

      it "doesn't create a new user" do
        expect{
          subject
        }.not_to change(User, :count)
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
