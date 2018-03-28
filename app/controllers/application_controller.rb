class ApplicationController < ActionController::API
  include Pundit
  include Errors

  rescue_from Pundit::NotAuthorizedError,         with: :not_allowed!
  rescue_from ActiveRecord::RecordNotFound,       with: :not_found!
  rescue_from ActionController::ParameterMissing, with: :params_required!

  after_action :verify_authorized

  def current_user; end
end
