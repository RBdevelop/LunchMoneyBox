Rails.application.configure do
      config.paperclip_defaults = {
        :storage => 's3',
        :s3_credentials => {
          :bucket => ENV['AWS_BUCKET'],
          :access_key_id => ENV['AWS_ACCESS_KEY_ID'],
          :secret_access_key => ENV['AWS_SECRET_ACCESS_KEY']
        }
      }
  config.cache_classes = false

  # Do not eager load code on boot.
  config.eager_load = false

  # Show full error reports and disable caching.
  config.consider_all_requests_local       = true

  config.action_controller.perform_caching = false

  config.action_mailer.default_url_options = { host: 'localhost', port:3000}

  config.action_mailer.raise_delivery_errors = true

  config.action_mailer.delivery_method = :smtp
  
  config.action_mailer.smtp_settings = {
    address: "smtp.gmail.com",
    port: 587,
    domain: 'lunchmoneybox.io',
    authentication: "plain",
    enable_starttls_auto: true,
    user_name: 'support@lunchmoneybox.io',
    password: '2015SAcatering',
    :openssl_verify_mode  => 'none'
    }

  # Print deprecation notices to the Rails logger.
  config.active_support.deprecation = :log

  # Raise an error on page load if there are pending migrations.
  config.active_record.migration_error = :page_load

  # Debug mode disables concatenation and preprocessing of assets.
  # This option may cause significant delays in view rendering with a large
  # number of complex assets.
  config.assets.debug = true

  # Asset digests allow you to set far-future HTTP expiration dates on all assets,
  # yet still be able to expire them through the digest params.
  config.assets.digest = true

  # Adds additional error checking when serving assets at runtime.
  # Checks for improperly declared sprockets dependencies.
  # Raises helpful error messages.
  config.assets.raise_runtime_errors = true

  # Raises error for missing translations
  # config.action_view.raise_on_missing_translations = true

end
