module Router
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
      Dir[Rails.root.join('config/routes/**/*.rb')]
    end
  end

  private

  def route_module(route_name)
    "Routes::#{route_name.to_s.camelize}".constantize
  end
end
