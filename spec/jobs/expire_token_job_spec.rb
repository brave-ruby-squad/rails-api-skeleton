require 'rails_helper'

describe ExpireTokenJob, type: :job do
  subject { described_class.perform_at(token.expired_at, token_id: token.id) }

  let!(:token) { create(:token) }

  before { Sidekiq::Testing.inline! }

  it 'calls Padlock::TokenDestroyer' do
    expect_any_instance_of(Padlock::TokenDestroyer).to receive(:call).and_return(true)

    subject
  end
end
