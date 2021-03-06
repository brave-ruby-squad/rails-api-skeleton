require_relative 'boot'

require_relative 'router'

require 'rails'
require 'active_model/railtie'
require 'active_job/railtie'
require 'active_record/railtie'
require 'action_controller/railtie'
require 'action_mailer/railtie'
require 'action_view/railtie'
# require 'rails/test_unit/railtie'

Bundler.require(*Rails.groups)

module RailsApiSkeleton
  class Application < Rails::Application
    config.load_defaults 5.1
    config.api_only = true
  end
end
