require 'spec_helper'

shared_examples 'success status' do
  it "returns HTTP status 'success'" do
    expect(response).to have_http_status :ok
  end
end
