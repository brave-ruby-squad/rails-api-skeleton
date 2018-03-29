require 'rails_helper'

RSpec.describe V1::Users::Update do
  let!(:user) { create(:user, old_attributes) }

  let(:old_attributes) { attributes_for(:user) }
  let(:new_attributes) { attributes_for(:user) }

  it 'updates user name' do
    expect{
      described_class.call(user: user, attributes: new_attributes)
    }.to change(user, :name).from(old_attributes[:name]).to(new_attributes[:name])
  end

  it 'updates user email' do
    expect{
      described_class.call(user: user, attributes: new_attributes)
    }.to change(user, :email).from(old_attributes[:email]).to(new_attributes[:email])
  end
end
