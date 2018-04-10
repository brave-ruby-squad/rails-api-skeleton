class ApplicationQuery < Commando::Base
  delegate :resource_class, :resource_name, to: :class

  def self.resource_name
    parent_name.singularize
  end

  def self.resource_class
    resource_name.constantize
  rescue NameError
    raise "Scope model haven't been defined"
  end

  def scope
    @result ||= resource_class.all
  end

  alias_method :result, :scope
end
