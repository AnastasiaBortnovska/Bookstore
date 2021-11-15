# frozen_string_literal: true

require 'active_support/core_ext/integer/time'

Rails.application.configure do

  config.cache_classes = true

  config.eager_load = true

  config.consider_all_requests_local       = false
  config.action_controller.perform_caching = true

  config.public_file_server.enabled = ENV['RAILS_SERVE_STATIC_FILES'].present?

  config.assets.compile = false

  config.active_storage.service = :amazon

  config.log_level = :info
  config.log_tags = [:request_id]

  config.action_mailer.perform_caching = false

  config.i18n.fallbacks = true

  config.active_support.deprecation = :notify
  config.active_support.disallowed_deprecation = :log
  config.active_support.disallowed_deprecation_warnings = []

  config.log_formatter = ::Logger::Formatter.new

  if ENV['RAILS_LOG_TO_STDOUT'].present?
    logger           = ActiveSupport::Logger.new($stdout)
    logger.formatter = config.log_formatter
    config.logger    = ActiveSupport::TaggedLogging.new(logger)
  end

  config.action_mailer.default_url_options = { host: 'https://bookstorebortnovska.herokuapp.com/' }
  config.action_mailer.delivery_method = :smtp
  config.action_mailer.smtp_settings = {
    user_name:      Rails.application.credentials.dig(:smtp, :user),
    password:       Rails.application.credentials.dig(:smtp, :password),
    domain:         'smtp.gmail.com',
    address:       'smtp.gmail.com',
    port:          '587',
    authentication: :login,
    enable_starttls_auto: true
  }

  config.active_record.dump_schema_after_migration = false

  config.seeds_enabled = false
  config.shrine_storage_s3 = true
  config.identify_local_server_ip = false
end
