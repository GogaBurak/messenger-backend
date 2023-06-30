# frozen_string_literal: true

# This file is copied to spec/ when you run 'rails generate rspec:install'
require 'spec_helper'
ENV['RAILS_ENV'] ||= 'test'
require_relative '../config/environment'
# Prevent database truncation if the environment is production
abort('The Rails environment is running in production mode!') if Rails.env.production?
require 'rspec/rails'
# Add additional requires below this line. Rails is not loaded until this point!
require 'shoulda/matchers'
require 'support/shoulda_matchers'
require 'helpers/request_helper'

# require all helpers
# Dir[Rails.root.join('spec', 'helpers', '**', '*.rb')].sort.each { |f| require f }

# Checks for pending migrations and applies them before tests are run.
# If you are not using ActiveRecord, you can remove these lines.
begin
  ActiveRecord::Migration.maintain_test_schema!
rescue ActiveRecord::PendingMigrationError => e
  abort e.to_s.strip
end
RSpec.configure do |config|
  # You can uncomment this line to turn off ActiveRecord support entirely.
  # config.use_active_record = false

  # auto-define spec type based on folder
  config.infer_spec_type_from_file_location!

  # Filter lines from Rails gems in backtraces.
  config.filter_rails_from_backtrace!
  # arbitrary gems may also be filtered via:
  # config.filter_gems_from_backtrace("gem name")

  config.before(:each, skip_authorization: true) do
    allow_any_instance_of(ApplicationController).to receive(:authorize_request).and_return(true)
  end

  config.include RequestHelper, type: :request
end
