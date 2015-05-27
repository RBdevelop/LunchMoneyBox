Rails.application.configure do
      config.paperclip_defaults = {
        :storage => 's3',
        :s3_credentials => {
          :bucket => ENV['AWS_BUCKET'],
          :access_key_id => ENV['AWS_ACCESS_KEY_ID'],
          :secret_access_key => ENV['AWS_SECRET_ACCESS_KEY']
        }
      }
  # Settings specified here will take precedence over those in config/application.rb.

  config.cache_classes = true

  config.eager_load = true

  config.consider_all_requests_local       = false
  config.action_controller.perform_caching = true

  config.serve_static_files = ENV['RAILS_SERVE_STATIC_FILES'].present?

  config.assets.js_compressor = :uglifier

  config.assets.compile = false

  config.assets.digest = true
 
  config.log_level = :debug

  config.action_mailer.default_url_options = { :host => 'lunchmoneybox.herokuapp.com' }
  
  config.action_mailer.delivery_method = :smtp
  
  config.action_mailer.perform_deliveries = true

  config.action_mailer.raise_delivery_errors = false

  config.action_mailer.default :charset => "utf-8"

  config.action_mailer.smtp_settings = {
    address: "smtp.gmail.com",
    port: 587,
    domain: ENV["GMAIL_DOMAIN"],
    authentication: "plain",
    enable_starttls_auto: true,
    user_name: ENV["GMAIL_USERNAME"],
    password: ENV["GMAIL_PASSWORD"],
    :openssl_verify_mode  => 'none'
    }

  Rails.application.routes.default_url_options[:host] = 'lunchmoneybox.herokuapp.com'

  config.i18n.fallbacks = true

  # Send deprecation notices to registered listeners.
  config.active_support.deprecation = :notify

  # Use default logging formatter so that PID and timestamp are not suppressed.
  config.log_formatter = ::Logger::Formatter.new

  # Do not dump schema after migrations.
  config.active_record.dump_schema_after_migration = false
end
