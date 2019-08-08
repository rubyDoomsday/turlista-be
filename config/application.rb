require_relative 'boot'

require "rails"
# Pick the frameworks you want:
require "active_model/railtie"
require "active_job/railtie"
require "active_record/railtie"
require "active_storage/engine"
require "action_controller/railtie"
require "action_mailer/railtie"
require "action_view/railtie"

Bundler.require(*Rails.groups)

module Turlista
  class Config
    APP_NAME  = ENV.fetch('APP_NAME', 'turlista')
    BASE_PATH = ENV.fetch('BASE_PATH','http://localhost:3000')
    DB_HOST   = ENV.fetch('DB_HOST', 'localhost')
    DB_PORT   = ENV.fetch('DB_PORT', '5432')
    DB_USER   = ENV.fetch('DB_USER', 'postgres')
    DB_PASS   = ENV.fetch('DB_PASS', 'password')
  end

  class Application < Rails::Application
    config.load_defaults 5.2

    # settings in config/environments/* take precedence over those specified here.
    # application configuration can go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded after loading
    # the framework and any gems in your application.

    # Only loads a smaller set of middleware suitable for API only apps.
    # Middleware like session, flash, cookies can be added back manually.
    # Skip views, helpers and assets when generating a new resource.
    config.api_only = true
  end
end
