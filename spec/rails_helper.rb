# frozen_string_literal: true

require 'simplecov'
SimpleCov.start do
  add_filter '/spec/'
end

ENV['RAILS_ENV'] ||= 'test'

ENGINE_ROOT = File.join(File.dirname(__FILE__), '../')

# Load environment.rb from the dummy app.
require File.expand_path('../dummy/config/environment', __FILE__)

abort('Rails is running in production!') if Rails.env.production?

require 'spec_helper'
require 'rspec/rails'
require 'rspec/active_model_serializers'

ActiveModelSerializers.config.schema_path = 'spec/support/schemas'
