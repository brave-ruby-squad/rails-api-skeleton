require 'spec_helper'

shared_examples 'no access token' do
  it 'returns no access token' do
    expect(response.header[Request::JsonHelpers::ACCESS_TOKEN_KEY]).to be_nil
  end
end
