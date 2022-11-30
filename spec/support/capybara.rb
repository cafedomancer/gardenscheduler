# frozen_string_literal: true

require 'capybara/rspec'
Capybara.register_driver :remote_chrome do |app|
  url = ENV['SELENIUM_DRIVER_URL']
  caps = Selenium::WebDriver::Remote::Capabilities.chrome(
    accept_insecure_certs: true,
    'goog:chromeOptions': {
      args: %w[
        --no-sandbox
        --headless
        --disable-gpu
        --window-size=1680,1050
      ]
    }
  )
  Capybara::Selenium::Driver.new(app, browser: :remote, url: url, capabilities: caps)
end

RSpec.configure do |config|
  config.before(:each, type: :system) do
    driven_by :rack_test
  end

  config.before(:each, type: :system, js: true) do
    Capybara.server_host = 'web'
    Capybara.app_host = 'http://web'
    driven_by :remote_chrome
  end
end
