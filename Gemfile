source "https://rubygems.org"
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby "2.6.2"

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem "rails", "~> 5.2.3"
# Use postgresql as the database for Active Record
gem "pg", ">= 0.18", "< 2.0"
# Use Puma as the app server
gem "puma", "~> 4.3"
# Use SCSS for stylesheets
gem "sass-rails", "~> 5.0"
# Use Uglifier as compressor for JavaScript assets
gem "uglifier", ">= 1.3.0"
# See https://github.com/rails/execjs#readme for more supported runtimes
# gem 'mini_racer', platforms: :ruby

# Turbolinks makes navigating your web application faster. Read more: https://github.com/turbolinks/turbolinks
gem "turbolinks", "~> 5"
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem "jbuilder", "~> 2.5"

# Grape and Swagger API
#
gem "grape", "~> 1.2.2"
gem "grape-entity", "~> 0.7.1"
gem "grape-swagger", "~> 0.31.0"
gem "grape-swagger-entity", "~> 0.3.0"
gem "grape-swagger-rails", "~> 0.3.0"
gem "grape_logging", "~> 1.8.0"

gem "rack-cors", "~> 1.0.5", require: "rack/cors"

# Use Redis adapter to run Action Cable in production
# gem 'redis', '~> 4.0'

# Use ActiveModel has_secure_password
gem "bcrypt", "~> 3.1.7"
gem "jwt", "~> 2.1.0"

# Use ActiveStorage variant
gem "image_processing", "~> 1.12"
# gem 'mini_magick', '~> 4.8'

# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development

# Reduces boot times through caching; required in config/boot.rb
gem "bootsnap", ">= 1.1.0", require: false

group :development, :test do
  gem "pry", "~> 0.11.3"
  gem "rubocop", "~> 0.59.2", require: false
  gem "rubocop-rails_config", "~> 0.2.5", require: false

  gem "rspec-rails", "~> 3.8"
  gem "factory_bot_rails", "~> 4.11.1"
  gem "shoulda-matchers", "4.0.0.rc1"
  gem "json_matchers"

  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem "byebug", platforms: [:mri, :mingw, :x64_mingw]
end

group :development do
  # Access an interactive console on exception pages or by calling 'console' anywhere in the code.
  gem "web-console", ">= 3.3.0"
  gem "listen", ">= 3.0.5", "< 3.2"
end
