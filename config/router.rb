module Router
  ROUTES_PATH = 'config/routes/**/*.rb'.freeze

  def specify(route_name)
    extend(route_module(route_name))

    call
  end

  class << self
    def included(_)
      routes.each(&method(:require))
    end

    private

    def routes
      Dir[Rails.root.join(ROUTES_PATH)]
    end
  end

  private

  def route_module(route_name)
    "Routes::#{route_resource(route_name)}".constantize
  end

  def route_resource(route_name)
    [@scope.namespace, route_name.to_s.camelize]
      .reject(&:blank?)
      .join('::')
  end
end
