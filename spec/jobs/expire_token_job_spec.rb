require 'rails_helper'

describe ExpireTokenJob, type: :job do
  subject { described_class.perform_now(token_id: token.id) }

  let!(:token) { create(:token) }

  it 'calls Padlock::TokenDestroyer' do
    expect_any_instance_of(Padlock::TokenDestroyer).to receive(:call).and_return(true)

    subject
  end
end
