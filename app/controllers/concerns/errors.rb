module Errors
  def not_allowed!
    render json:   { error: { user_authorization: 'You are not authorized to do that.' } },
           status: :unauthorized
  end

  def not_found!; end

  def params_required!; end

  def unauthorized!
    render json: { error: { user_authentication: 'Invalid credentials.' } }, status: :unauthorized
  end
end
