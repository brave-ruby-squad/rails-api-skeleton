require 'rails_helper'

describe Padlock::TokenDestroyer do
  subject { described_class.call(token: token) }

  let!(:token) { create(:token) }

  it 'deletes a token' do
    expect{ subject }.to change(Token, :count).by(-1)
  end

  it 'returns true' do
    expect(subject.key).to be_truthy
  end

  context 'when there token is not persisted' do
    let(:token) { build(:token) }

    it 'returns false' do
      expect(subject.key).to be_truthy
    end
  end
end
