require_relative "boot"

require "rails/all"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module RailsApp
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 6.1

    config.generators do |g|
      g.helper          false
      g.test_framework  false
			# stylesheets, javascripts, images, etc.
      g.assets          false
			# not auto generate all the routes
      g.skip_routes     true
    end

  end
end
