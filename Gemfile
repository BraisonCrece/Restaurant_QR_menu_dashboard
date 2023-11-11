source "https://rubygems.org"
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby "3.1.2"

# Handle User Authentication easily
gem 'devise'

# HTTParty is a simple Ruby library for making HTTP requests, handling various protocols, and processing JSON, XML, and other formats in a user-friendly manner
gem 'httparty'

# Dotenv-rails is a Ruby gem that loads environment variables from a .env file into your Rails application, allowing you to keep sensitive information secure and separate from your codebase.
gem 'dotenv-rails'

# Rack middleware for handling Cross-Origin Resource Sharing (CORS), which allows sharing of resources between different domains.
gem 'rack-cors'

# Allows us to process images using the Active Storage framework in Rails. [https://github.com/janko/image_processing]
gem "image_processing", ">= 1.2"

# PSQL gem (used on Fly.io deployment)
gem "pg", "~> 1.4"

# animate.style animatio framework
gem 'animate-rails'

# Bundle edge Rails instead: gem "rails", github: "rails/rails", branch: "main"
gem "rails", "~> 7.0.4", ">= 7.0.4.1"

# The original asset pipeline for Rails [https://github.com/rails/sprockets-rails]
gem "sprockets-rails"

# Use sqlite3 as the database for Active Record
gem "sqlite3", "~> 1.4"

# Use the Puma web server [https://github.com/puma/puma]
gem "puma", "~> 5.0"

# Use JavaScript with ESM import maps [https://github.com/rails/importmap-rails]
gem "importmap-rails"

# Hotwire's SPA-like page accelerator [https://turbo.hotwired.dev]
gem "turbo-rails"

# Hotwire's modest JavaScript framework [https://stimulus.hotwired.dev]
gem "stimulus-rails"

# Use Tailwind CSS [https://github.com/rails/tailwindcss-rails]
gem "tailwindcss-rails"

# Build JSON APIs with ease [https://github.com/rails/jbuilder]
gem "jbuilder"

# Use Redis adapter to run Action Cable in production
gem "redis", "~> 4.0"

# Use Kredis to get higher-level data types in Redis [https://github.com/rails/kredis]
# gem "kredis"

# Use Active Model has_secure_password [https://guides.rubyonrails.org/active_model_basics.html#securepassword]
# gem "bcrypt", "~> 3.1.7"

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem "tzinfo-data", platforms: %i[ mingw mswin x64_mingw jruby ]

# Reduces boot times through caching; required in config/boot.rb
gem "bootsnap", require: false

# Use Sass to process CSS
# gem "sassc-rails"

# Use Active Storage variants [https://guides.rubyonrails.org/active_storage_overview.html#transforming-images]
# gem "image_processing", "~> 1.2"

group :development, :test do
  # See https://guides.rubyonrails.org/debugging_rails_applications.html#debugging-with-the-debug-gem
  gem "debug", platforms: %i[ mri mingw x64_mingw ]
  # Use system testing [https://guides.rubyonrails.org/testing.html#system-testing]
  gem 'rspec-rails', '~> 6.0.0'
  gem "capybara"
  gem 'capybara-screenshot'
  gem "selenium-webdriver"
  gem "webdrivers", "= 5.3.0"
  gem "factory_bot_rails", "~> 6.2"
  gem "faker", "~> 3.1"
  gem 'shoulda-matchers', "~> 5.0"
end

group :development do
  # Use console on exceptions pages [https://github.com/rails/web-console]
  gem "web-console"

  # Fly.io dockerfile generator
  gem "dockerfile-rails", ">= 1.2"

  # Add speed badges [https://github.com/MiniProfiler/rack-mini-profiler]
  # gem "rack-mini-profiler"

  # Speed up commands on slow machines / big apps [https://github.com/rails/spring]
  # gem "spring"
end







