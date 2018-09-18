require 'rails_helper'

RSpec.describe Identity, type: :model do
  before { build(:identity) }

  it { should belong_to(:user) }
  it { should validate_presence_of(:uid) }
  it { should validate_presence_of(:provider) }
end
