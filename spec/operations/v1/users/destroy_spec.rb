require 'rails_helper'

RSpec.describe V1::Users::Destroy do
  let!(:user)  { create(:user) }
  let(:result) { described_class.call(user: user) }

  it 'destroys user' do
    expect{ result }.to change(User, :count).by(-1)
  end
end
