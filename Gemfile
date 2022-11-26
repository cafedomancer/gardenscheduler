source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '3.1.3'

gem 'rails', '~> 6.1.6', '>= 6.1.6.1'
# gem 'pg', '~> 1.1'
gem 'puma', '~> 5.0'
gem 'sass-rails', '>= 6'
gem 'webpacker', '~> 5.0'
gem 'turbolinks', '~> 5'
gem 'jbuilder', '~> 2.7'
# Use Redis adapter to run Action Cable in production
# gem 'redis', '~> 4.0'
# Use Active Model has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Use Active Storage variant
# gem 'image_processing', '~> 1.2'

gem 'bootsnap', '>= 1.4.4', require: false
gem 'net-smtp'
gem 'net-imap'
gem 'net-pop'
gem 'devise'
gem 'devise-i18n'
gem 'omniauth-line'
gem 'omniauth-rails_csrf_protection'
gem 'dotenv-rails'
gem 'activeadmin'
gem 'rails-i18n'
gem 'active_hash'
gem 'kaminari'
gem 'cocoon'
gem 'deep_cloneable', '~> 3.2.0'
gem 'rubocop-rails', require: false
gem 'mini_magick', '~> 4.11'
gem 'image_processing', '~> 1.2'
gem "aws-sdk-s3", require: false
gem 'line-bot-api'
gem 'mysql2', '~> 0.5'
gem 'whenever', require: false

group :development, :test do
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
  gem 'rspec-rails', '~> 6.0.0'
  gem 'factory_bot_rails'
  gem 'faker'
end

group :development do
  gem 'web-console', '>= 4.1.0'
  gem 'rack-mini-profiler', '~> 2.0'
  gem 'listen', '~> 3.3'
  gem 'spring'
  gem 'spring-commands-rspec'
end

group :test do
  gem 'capybara'
  gem 'selenium-webdriver'
  # gem 'webdrivers'
  gem 'database_cleaner'
end

gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]

group :production, :staging do
    gem 'unicorn'
end
