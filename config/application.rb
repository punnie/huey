require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Huey
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 7.0

    # Configuration for the application, engines, and railties goes here.
    #
    # These settings can be overridden in specific environments using the files
    # in config/environments, which are processed later.
    #
    # config.time_zone = "Central Time (US & Canada)"
    # config.eager_load_paths << Rails.root.join("extras")

    # Autoload lib directory
    config.autoload_paths << Rails.root.join('lib')
    config.eager_load_paths << Rails.root.join('lib')

    %w[assets generators tasks templates].each do |subdir|
      Rails.autoloaders.main.ignore("#{Rails.root}/lib/#{subdir}")
    end

    # Disable legacy connection handling
    config.active_record.legacy_connection_handling = false

    # Use SQL to store the database schema
    config.active_record.schema_format = :sql

    # Set Sidekiq as activejob adapter
    config.active_job.queue_adapter = :sidekiq
  end
end
