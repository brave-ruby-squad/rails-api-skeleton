require "rails_helper"

RSpec.describe UserPolicy do
  let(:user)           { create(:user) }
  let(:resource_class) { User }

  subject { described_class }

  permissions :index? do
    it_behaves_like 'is allowed'
  end

  permissions :show? do
    it_behaves_like 'can authenticated'
  end

  permissions :update? do
    it_behaves_like 'can authenticated'
  end

  permissions :destroy? do
    it_behaves_like 'can authenticated'
  end
end
