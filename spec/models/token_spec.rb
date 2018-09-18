require 'rails_helper'

RSpec.describe Token, type: :model do
  before { create(:token) }

  it { should belong_to(:user) }
  it { should validate_presence_of(:key) }
  it { should validate_presence_of(:key_type) }
  it { should validate_presence_of(:expired_at) }
end
