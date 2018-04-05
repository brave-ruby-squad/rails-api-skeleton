class UserPolicy < ApplicationPolicy
  alias_method :index?,   :allowed?
  alias_method :show?,    :authenticated?
  alias_method :update?,  :authenticated?
  alias_method :destroy?, :authenticated?

  public :index?, :show?, :update?, :destroy?
end
