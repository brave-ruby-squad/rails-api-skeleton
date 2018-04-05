require 'spec_helper'

shared_examples 'can authenticated' do
  let(:user)                  { build(:user) }
  let(:policy_resource_class) { respond_to?(:resource_class) ? resource_class : nil }
  let(:policy_resource)       { respond_to?(:resource) ? resource : policy_resource_class&.new }

  it { should_not permit(nil, policy_resource) }
  it { should     permit(user, policy_resource) }
end
