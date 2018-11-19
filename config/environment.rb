# Load the Rails application.
require_relative "application"

# Initialize the Rails application.
Rails.application.initialize!

# default host parameter
Rails.application.routes.default_url_options[:host] = ENV.fetch("HTTP_HOST", "localhost:3000")
