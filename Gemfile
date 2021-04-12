# frozen_string_literal: true

source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.7.2'

gem 'aasm', '~> 5.1.1'
gem 'activeadmin', '~> 2.9.0'
gem 'bootsnap', '>= 1.4.4', require: false
gem 'cancancan', '~> 3.2.1'
gem 'coffee-rails', '~> 4.2'
gem 'country_select', '~> 5.0.1'
gem 'devise', '~> 4.7.3'
gem 'draper', '~> 4.0.1'
gem 'haml-rails', '~> 2.0'
gem 'jbuilder', '~> 2.7'
gem 'mini_magick', '~> 4.11.0'
gem 'omniauth-facebook', '~> 8.0.0'
gem 'pg', '~> 1.1'
gem 'puma', '~> 5.0'
gem 'rails', '~> 6.1.3'
gem 'rectify', '~> 0.13.0'
gem 'sass-rails', '>= 6'
gem 'simple_form', '~> 5.0'
gem 'turbolinks', '~> 5'
gem 'uglifier', '>= 1.3.0'
gem 'webpacker', '~> 5.0'
gem 'wicked', '~> 1.3.4'

group :development, :test do
  gem 'byebug', '~> 11.1.3', platforms: %i[mri mingw x64_mingw]
  gem 'faker', '~> 2.17.0', require: false
  gem 'rspec', '~> 3.10.0'
  gem 'rspec-rails', '~> 5.0.1'
end

group :development do
  gem 'brakeman', '~> 5.0.0'
  gem 'bullet', '~> 6.1.4'
  gem 'database_consistency', '~> 0.8.13', require: false
  gem 'fasterer', '~> 0.9.0'
  gem 'listen', '~> 3.5.1'
  gem 'overcommit', '~> 0.57.0'
  gem 'pry-rails', '~> 0.3.9'
  gem 'rack-mini-profiler', '~> 2.0'
  gem 'reek', '~> 6.0.3'
  gem 'rubocop', '~> 1.12.0', require: false
  gem 'rubocop-performance', '~> 1.10.2'
  gem 'rubocop-rails', '~> 2.9.1'
  gem 'rubocop-rspec', '~> 2.2.0'
  gem 'spring', '~> 2.1.1'
  gem 'spring-watcher-listen', '~> 2.0.1'
  gem 'traceroute', '~> 0.8.1'
  gem 'web-console', '>= 4.1.0'
end

group :test do
  gem 'capybara', '>= 3.26'
  gem 'capybara-screenshot', '~> 1.0.25'
  gem 'factory_bot_rails', '~> 6.1.0'
  gem 'rails-controller-testing', '~> 1.0.5'
  gem 'selenium-webdriver', '~> 3.142.7'
  gem 'shoulda-matchers', '~> 4.5.1'
  gem 'simplecov', '~> 0.21.2'
  gem 'site_prism', '~> 3.7.1'
  gem 'webdrivers', '~> 4.6.0'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', '~> 1.2021.1', platforms: %i[mingw mswin x64_mingw jruby]
