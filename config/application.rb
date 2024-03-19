require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module CartaQr
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 7.0

    config.rails_i18n.enabled_modules = [:locale]
    # Spanish, German, English, Italian, French, Russian
    config.i18n.available_locales = %i[gl es de en it fr ru]
    config.i18n.default_locale = :gl

    # ../data/locales
    config.i18n.load_path += Dir[Rails.root.join('..', 'data', 'locales', '*.{rb,yml}')]

    # add services
    # config.autoload_paths += %W(#{config.root}/app/services)

    # Configuration for the application, engines, and railties goes here.
    #
    # These settings can be overridden in specific environments using the files
    # in config/environments, which are processed later.
    #
    # config.time_zone = "Central Time (US & Canada)"
    # config.eager_load_paths << Rails.root.join("extras")
  end
end
