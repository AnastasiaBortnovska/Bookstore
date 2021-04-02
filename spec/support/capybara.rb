require 'capybara/rspec'
require 'capybara-screenshot/rspec'
require 'selenium-webdriver'
require 'site_prism'
require 'site_prism/all_there'

Capybara.register_driver :site_prism do |app|
  browser = ENV.fetch('browser', 'firefox').to_sym
  Capybara::Selenium::Driver.new(app, browser: browser, desired_capabilities: capabilities)
end

Capybara.configure do |config|
  config.default_driver = :site_prism
end
