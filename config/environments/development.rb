Ocill::Application.configure do
  # Settings specified here will take precedence over those in config/application.rb

  # In the development environment your application's code is reloaded on
  # every request. This slows down response time but is perfect for development
  # since you don't have to restart the web server when you make code changes.
  config.cache_classes = false

  # Show full error reports and disable caching
  config.consider_all_requests_local       = true
  config.action_controller.perform_caching = false
  # Don't care if the mailer can't send
  # config.action_mailer.raise_delivery_errors = false

  # Print deprecation notices to the Rails logger
  config.active_support.deprecation = :log

  # Only use best-standards-support built into browsers
  # config.action_dispatch.best_standards_support = :builtin

  # Raise exception on mass assignment protection for Active Record models
  config.active_record.mass_assignment_sanitizer = :strict

  config.eager_load = false
 
  # Do not compress assets
  config.assets.compress = false

  # Expands the lines which load the assets
  config.assets.debug = true

  #  Helpful for active_admin/devise
  config.action_mailer.default_url_options = { :host => "localhost:3000" }
  
  config.action_mailer.smtp_settings = {
    :address   => "smtp.mandrillapp.com",
    :port      => 587, # ports 587 and 2525 are also supported with STARTTLS
    :enable_starttls_auto => true, # detects and uses STARTTLS
    :user_name => "app7521947@heroku.com",
    :password  => ENV["MANDRILL_KEY"], # SMTP password is any valid API key
    :authentication => 'login', # Mandrill supports 'plain' or 'login'
    :domain => 'ocill.herokuapp.com', # your domain to identify your server when connecting
  }
  
  ENV['PANDASTREAM_URL'] = "https://8004343febe45d829904:e8ccc0128cec99762880@api.pandastream.com/25ce2dfe445167db12c3aaa1aee6879a"
  silence_warnings do
    begin
      require 'pry'
      IRB = Pry
    rescue LoadError
  end
end
end
