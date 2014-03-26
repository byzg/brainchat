require 'rubygems'
require 'mocha/api'
if ENV['COVERAGE']
  require 'simplecov'
  SimpleCov.start 'rails'
end

ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../../config/environment', __FILE__)
require 'cucumber/rails'

unless ENV['SHOWME']
  require 'capybara/poltergeist'
  Capybara.register_driver :poltergeist do |app|
    Capybara::Poltergeist::Driver.new(app, {
        debug: false,
        inspector: false,
        phantomjs_options: %w(--ignore-ssl-errors=yes),
        js_errors: false
    })
  end
  Capybara.javascript_driver = :poltergeist
end

Capybara.server_port = 31337
ActionController::Base.allow_rescue = true
DatabaseCleaner.strategy = :transaction
Cucumber::Rails::Database.javascript_strategy = :truncation

Before do
  mocha_setup
end

After do
  begin
    mocha_verify
  ensure
    mocha_teardown
  end
end