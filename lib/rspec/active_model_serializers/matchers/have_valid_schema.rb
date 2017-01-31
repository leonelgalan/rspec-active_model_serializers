# frozen_string_literal: true

require 'active_model_serializers'

AssertSchema = ActiveModelSerializers::Test::Schema::AssertSchema

module RSpec
  module ActiveModelSerializers
    module Matchers
      module HaveValidSchema
        RSpec::Matchers.define :have_valid_schema do
          chain :at_path do |schema_path|
            @schema_path = schema_path
          end

          match do
            @matcher = AssertSchema.new(@schema_path, request, response, nil)
            @matcher.call
          end

          failure_message do
            @matcher.message
          end
        end
      end
    end
  end
end
