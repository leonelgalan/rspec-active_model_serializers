# frozen_string_literal: true

require 'rails_helper'

ActiveModelSerializers.config.schema_path = 'spec/support/schemas'

RSpec.describe ProfilesController, type: :controller do
  it 'test_that_assert_with_a_valid_schema' do
    get :index
    expect(response).to have_valid_schema
  end

  it 'test_that_raises_a_minitest_error_with_a_invalid_schema' do
    message = "#/name: failed schema #/properties/name: For 'properties/name'" \
              ', "Name 1" is not an integer. and #/description: failed ' \
              "schema #/properties/description: For 'properties/description'" \
              ', "Description 1" is not a boolean.'

    get :show

    expect do
      expect(response).to have_valid_schema
    end.to raise_error(RSpec::Expectations::ExpectationNotMetError, message)
  end

  it 'test_that_raises_error_with_a_custom_message_with_a_invalid_schema' do
    message = 'oh boy the show is broken'

    get :show

    expect do
      expect(response).to have_valid_schema, message
    end.to raise_error(RSpec::Expectations::ExpectationNotMetError, message)
  end

  it 'test_that_assert_with_a_custom_schema' do
    get :show
    expect(response).to have_valid_schema.at_path 'custom/show.json'
  end

  it 'test_that_assert_with_a_hyper_schema' do
    get :show
    expect(response).to have_valid_schema.at_path 'hyper_schema.json'
  end

  it 'test_simple_json_pointers' do
    get :show
    expect(response).to have_valid_schema.at_path 'simple_json_pointers.json'
  end

  it 'test_simple_json_pointers_that_doesnt_match' do
    get :name_as_a_integer

    expect do
      expect(response).to have_valid_schema.at_path 'simple_json_pointers.json'
    end.to raise_error(RSpec::Expectations::ExpectationNotMetError)
  end

  it 'test_json_api_schema' do
    get :render_using_json_api
    expect(response).to have_valid_schema.at_path 'render_using_json_api.json'
  end

  it 'test_that_assert_with_a_custom_schema_directory' do
    original_schema_path = ActiveModelSerializers.config.schema_path
    ActiveModelSerializers.config.schema_path = 'spec/support/custom_schemas'

    get :index
    expect(response).to have_valid_schema

    ActiveModelSerializers.config.schema_path = original_schema_path
  end

  it 'test_with_a_non_existent_file' do
    message = 'No Schema file at spec/support/schemas/non-existent.json'

    get :show

    expect do
      expect(response).to have_valid_schema.at_path 'non-existent.json'
    end.to raise_error(ActiveModelSerializers::Test::Schema::MissingSchema,
                       message)
  end

  it 'test_that_raises_with_a_invalid_json_body' do
    message = /A JSON text must at least contain two octets|unexpected token at ''/

    get :invalid_json_body

    expect do
      expect(response).to have_valid_schema.at_path('custom/show.json')
    end.to raise_error(ActiveModelSerializers::Test::Schema::InvalidSchemaError,
                       message)
  end
end