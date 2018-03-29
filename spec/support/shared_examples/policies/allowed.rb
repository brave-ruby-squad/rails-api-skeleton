require 'spec_helper'

shared_examples 'is allowed' do
  it { should permit(nil, nil) }
end
