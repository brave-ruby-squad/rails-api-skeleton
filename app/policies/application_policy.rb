class ApplicationPolicy
  def initialize(user, resource, **context)
    @user     = user
    @resource = resource
    @context  = context
  end

  private

  attr_reader :user, :resource, :context

  def allowed?
    true
  end

  def authenticated?
    user.present?
  end
end
