require File.expand_path('../boot', __FILE__)

require 'rails/all'
require 'net/pop'

Bundler.require(*Rails.groups)

module Mailchat
  class Application < Rails::Application
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    # Set Time.zone default to the specified zone and make Active Record auto-convert to this zone.
    # Run "rake -D time" for a list of tasks for finding time zone names. Default is UTC.
    config.time_zone = 'Moscow' # +0400

    # The default locale is :en and all translations from config/locales/*.rb,yml are auto loaded.
    config.i18n.load_path += Dir[Rails.root.join('config', 'locales', '**', '*.{rb,yml}')]
    config.i18n.default_locale = :ru

    #require 'i18n/missing_translations'
    #config.app_middleware.use(I18n::MissingTranslations) if Rails.env.development?e

    config.assets.initialize_on_precompile = false

    config.generators do |g|
      g.view_specs false
      g.helper_specs false
      g.controller_specs false
      g.assets = false
      g.helper = false
    end

    config.to_prepare do
      Devise::SessionsController.skip_before_filter :set_account_password, :only => [:destroy]
    end
    config.action_controller.action_on_unpermitted_parameters = :raise
  end
end
