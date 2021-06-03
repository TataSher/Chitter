# frozen_string_literal: true

require 'capybara'
require 'capybara/rspec'
require 'rspec'
require 'setup_test_database'

ENV['RACK_ENV'] = 'test'

require File.join(File.dirname(__FILE__), '..', 'app.rb')

RSpec.configure do |config|
  config.before(:each) do
    setup_test_database
    add_users
    add_peeps
  end
end

Capybara.app = Chitter

RSpec.configure do |config|
  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end

  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end

  config.shared_context_metadata_behavior = :apply_to_host_groups
end
