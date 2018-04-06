require 'spec_helper'

shared_examples 'access token' do
  it 'returns access token in the header' do
    expect(response.header[Request::JsonHelpers::ACCESS_TOKEN_KEY]).not_to be_empty
  end
end
