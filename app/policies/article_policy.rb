class ArticlePolicy < ApplicationPolicy
  alias_method :index?,  :allowed?
  alias_method :create?, :authenticated?

  public :index?, :create?
end
