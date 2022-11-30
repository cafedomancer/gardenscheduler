# frozen_string_literal: true

source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '3.1.3'

gem 'activeadmin'
gem 'active_hash'
gem 'aws-sdk-s3', require: false
gem 'bootsnap', '>= 1.4.4', require: false
gem 'cocoon'
gem 'deep_cloneable', '~> 3.2.0'
gem 'devise'
gem 'devise-i18n'
gem 'dotenv-rails'
gem 'image_processing', '~> 1.2'
gem 'jbuilder', '~> 2.7'
gem 'kaminari'
gem 'line-bot-api'
gem 'mini_magick', '~> 4.11'
gem 'mysql2', '~> 0.5'
gem 'net-imap'
gem 'net-pop'
gem 'net-smtp'
gem 'omniauth-line'
gem 'omniauth-rails_csrf_protection'
gem 'puma', '~> 5.0'
gem 'rails', '~> 6.1.6', '>= 6.1.6.1'
gem 'rails-i18n'
gem 'sass-rails', '>= 6'
gem 'turbolinks', '~> 5'
gem 'tzinfo-data', platforms: %i[mingw mswin x64_mingw jruby]
gem 'webpacker', '~> 5.0'
gem 'whenever', require: false

group :development, :test do
  gem 'byebug', platforms: %i[mri mingw x64_mingw]
  gem 'factory_bot_rails'
  gem 'faker'
  gem 'rspec-rails', '~> 6.0.0'
  gem 'rubocop', require: false
  gem 'rubocop-fjord', '~> 0.2.0', require: false
  gem 'rubocop-rails', require: false
end

group :development do
  gem 'listen', '~> 3.3'
  gem 'rack-mini-profiler', '~> 2.0'
  gem 'spring'
  gem 'spring-commands-rspec'
  gem 'web-console', '>= 4.1.0'
end

group :test do
  gem 'capybara'
  gem 'database_cleaner'
  gem 'selenium-webdriver'
  gem 'webdrivers'
end

group :production, :staging do
  gem 'unicorn'
end
