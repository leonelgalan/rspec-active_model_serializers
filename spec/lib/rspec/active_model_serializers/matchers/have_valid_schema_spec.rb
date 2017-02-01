# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ProfilesController, type: :controller do
  context 'using the schemas in the default schema_path' do
    it 'validates :index response with profile/index.json ' do
      get :index
      expect(response).to have_valid_schema
    end

    context "doesn't validate :show with profiles/show.json " do
      before { get :show }

      it 'is expected not to validate' do
        expect(response).not_to have_valid_schema
      end

      it 'allows to customize the failure message' do
        message = 'oh boy the show is broken'
        expect { expect(response).to have_valid_schema, message }.to(
          raise_error(RSpec::Expectations::ExpectationNotMetError, message)
        )
      end
    end
  end

  context 'customizing the schema_path globally' do
    around(:example) do |example|
      original_schema_path = ActiveModelSerializers.config.schema_path
      ActiveModelSerializers.config.schema_path = 'spec/support/custom_schemas'
      example.run
      ActiveModelSerializers.config.schema_path = original_schema_path
    end

    it 'validates :index with custom_schemas/profiles/index.json' do
      get :index
      expect(response).to have_valid_schema
    end
  end

  context 'overrides schema_path passing it on every expectation' do
    it 'validates :show with custom/show.json' do
      get :show
      expect(response).to have_valid_schema.at_path 'custom/show.json'
    end

    it 'validates :show with a hyper schema' do
      get :show
      expect(response).to have_valid_schema.at_path 'hyper_schema.json'
    end

    it 'validates :show with a simple json pointers schema' do
      get :show
      expect(response).to have_valid_schema.at_path 'simple_json_pointers.json'
    end

    it "doesn't validate :name_as_integer with a simple pointers schema " do
      get :name_as_a_integer
      expect do
        expect(response).to(
          have_valid_schema.at_path('simple_json_pointers.json')
        )
      end.to raise_error(RSpec::Expectations::ExpectationNotMetError)
    end

    it 'validates :render_using_json_api with the proper schema' do
      get :render_using_json_api
      expect(response).to have_valid_schema.at_path 'render_using_json_api.json'
    end

    context 'errors' do
      it 'raises error with non-existent schema' do
        message = 'No Schema file at spec/support/schemas/non-existent.json'
        get :show
        expect do
          expect(response).to have_valid_schema.at_path 'non-existent.json'
        end.to raise_error(ActiveModelSerializers::Test::Schema::MissingSchema,
                           message)
      end

      it 'raises error with invalid response (not JSON)' do
        get :invalid_json_body
        expect do
          expect(response).to have_valid_schema.at_path('custom/show.json')
        end.to raise_error(
          ActiveModelSerializers::Test::Schema::InvalidSchemaError,
          /A JSON text must at least contain two octets|unexpected token at ''/
        )
      end
    end
  end
end
