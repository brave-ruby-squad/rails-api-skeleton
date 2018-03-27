Rails.application.configure do
  config.cache_classes = true
  config.eager_load    = true

  config.consider_all_requests_local       = false
  config.action_controller.perform_caching = true

  config.read_encrypted_secrets = true

  config.public_file_server.enabled = ENV['RAILS_SERVE_STATIC_FILES'].present?

  config.log_level = :debug

  config.log_tags = %i[request_id]

  config.action_mailer.default_url_options   = { host: 'http://localhost:3000' }
  config.action_mailer.delivery_method       = :smtp
  config.action_mailer.perform_deliveries    = true
  config.action_mailer.raise_delivery_errors = false
  config.action_mailer.default               charset: 'utf-8'
  config.action_mailer.smtp_settings         = {
    address:              'smtp.gmail.com',
    port:                 587,
    domain:               'example.com',
    user_name:            ENV['GMAIL_ACCOUNT'],
    password:             ENV['GMAIL_PASSWORD'],
    authentication:       'plain',
    enable_starttls_auto: true
  }

  config.i18n.fallbacks = true

  config.active_support.deprecation = :notify

  config.log_formatter = ::Logger::Formatter.new

  if ENV['RAILS_LOG_TO_STDOUT'].present?
    logger           = ActiveSupport::Logger.new(STDOUT)
    logger.formatter = config.log_formatter
    config.logger    = ActiveSupport::TaggedLogging.new(logger)
  end

  config.active_record.dump_schema_after_migration = false
end
