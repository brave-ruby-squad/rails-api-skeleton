require 'rails_helper'

describe User, type: :model do
  before { build(:user) }

  it { should have_many(:identities) }
  it { should have_many(:tokens) }
  it { should validate_presence_of(:password) }
  it { should validate_presence_of(:password_confirmation) }
end
