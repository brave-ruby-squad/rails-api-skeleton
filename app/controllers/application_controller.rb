class ApplicationController < ActionController::API
  include Pundit
  include Errors

  rescue_from Pundit::NotAuthorizedError,         with: :not_allowed!
  rescue_from ActiveRecord::RecordNotFound,       with: :not_found!
  rescue_from ActionController::ParameterMissing, with: :params_required!

  before_action :authenticate_user
  after_action  :verify_authorized

  attr_reader :current_user

  private

  def authenticate_user
    @current_user = Padlock::Verifier.call(request.headers)
  end
end
