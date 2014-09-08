# This file is copied to spec/ when you run 'rails generate rspec:install'
ENV["RAILS_ENV"] ||= 'test'
require 'spec_helper'
require File.expand_path("../../config/environment", __FILE__)
require 'rspec/rails'
require 'shoulda/matchers'
require 'capybara/rails'

Capybara.server_port = 50924
Capybara.javascript_driver = :webkit

Dir[Rails.root.join("spec/support/**/*.rb")].each { |f| require f }
ActiveRecord::Migration.maintain_test_schema!

OmniAuth.config.test_mode = true
omniauth_hash = { 
  'provider' => 'github',
  'uid' => '12345',
  'info' => {
    'name' => 'Test User',
    'email' => 'test@example.com',
    'nickname' => 'testuser',
    'urls' => {'GitHub' => 'http://test.com'}
  },
  'credentials' => {"token"=>"123", "expires"=>false}
}

OmniAuth.config.add_mock(:github, omniauth_hash)

VCR.configure do |c|
  c.cassette_library_dir = 'spec/cassettes'
  c.hook_into :webmock
  c.configure_rspec_metadata!
  c.ignore_localhost = true
end

RSpec.configure do |config|
  config.fixture_path = "#{::Rails.root}/spec/fixtures"
  config.use_transactional_fixtures = true
  config.infer_spec_type_from_file_location!
end
