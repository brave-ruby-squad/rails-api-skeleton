require 'spec_helper'

shared_examples 'unprocessable entity status' do
  it "returns HTTP status 'unprocessable_entity'" do
    expect(response).to have_http_status :unprocessable_entity
  end
end
