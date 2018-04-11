class ExpireTokenJob
  include Sidekiq::Worker

  def perform(params = {})
    token = Token.find_by(id: params[:token_id])

    Padlock::TokenDestroyer.call(token: token)
  end
end
