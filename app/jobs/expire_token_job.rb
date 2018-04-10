class ExpireTokenJob < ApplicationJob
  queue_as :default

  def perform(**params)
    token = Token.find_by(id: params[:token_id])

    Padlock::TokenDestroyer.call(token: token)
  end
end
