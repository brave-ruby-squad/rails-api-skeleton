class ExpireTokenJob < ApplicationJob
  def perform(token_id)
    token = Token.find_by(id: token_id)

    Padlock::TokenDestroyer.call(token: token)
  end
end
