require File.expand_path('../boot', __FILE__)

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(:default, Rails.env)

require File.expand_path('../../lib/configus', __FILE__)

module Waytag
  class Application < Rails::Application
    config.i18n.default_locale = :ru

    config.autoload_paths += Dir["#{config.root}/lib/**/"]

    config.time_zone = 'Moscow'

    config.generators do |g|
      g.template_engine :haml
      g.stylesheets false
      g.javascripts false
      g.helper false
    end
  end
end
