require_relative 'boot'

require "rails"
# Pick the frameworks you want:
require "active_model/railtie"
require "active_job/railtie"
require "active_record/railtie"
require "action_controller/railtie"
require "action_mailer/railtie"
require "action_view/railtie"
require "action_cable/engine"
# require "sprockets/railtie"
# require "rails/test_unit/railtie"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module ApiBase
  class Application < Rails::Application
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    # Only loads a smaller set of middleware suitable for API only apps.
    # Middleware like session, flash, cookies can be added back manually.
    # Skip views, helpers and assets when generating a new resource.
    config.api_only = true

    config.middleware.insert_before 0, "Rack::Cors", :logger => (-> { Rails.logger }) do
      allow do
        origins '*'

        resource '*',
          :headers => :any,
          :methods => [:get, :post, :delete, :put, :options, :head, :patch],
          :max_age => 0
      end
    end

    config.active_job.queue_adapter = :sidekiq

    # Application level custom configuration
    config.application_display_name = "BaseApp"

    config.action_mailer.delivery_method = :smtp

    config.action_mailer.perform_deliveries = true

  end
end
