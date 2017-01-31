# frozen_string_literal: true

require 'rspec/active_model_serializers/matchers/have_valid_schema'

RSpec.configure do |config|
  config.include RSpec::ActiveModelSerializers::Matchers::HaveValidSchema,
                 type: :request
  config.include RSpec::ActiveModelSerializers::Matchers::HaveValidSchema,
                 type: :controller
end
