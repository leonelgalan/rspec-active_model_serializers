# rspec-active_model_serializers

[![Build Status](https://travis-ci.org/leonelgalan/rspec-active_model_serializers.svg?branch=master)](https://travis-ci.org/leonelgalan/rspec-active_model_serializers)
[![Code Climate](https://codeclimate.com/github/leonelgalan/rspec-active_model_serializers/badges/gpa.svg)](https://codeclimate.com/github/leonelgalan/rspec-active_model_serializers)
[![Test Coverage](https://codeclimate.com/github/leonelgalan/rspec-active_model_serializers/badges/coverage.svg)](https://codeclimate.com/github/leonelgalan/rspec-active_model_serializers/coverage)
[![Issue Count](https://codeclimate.com/github/leonelgalan/rspec-active_model_serializers/badges/issue_count.svg)](https://codeclimate.com/github/leonelgalan/rspec-active_model_serializers)
[![Dependency Status](https://gemnasium.com/badges/github.com/leonelgalan/rspec-active_model_serializers.svg)](https://gemnasium.com/github.com/leonelgalan/rspec-active_model_serializers)
[![Gem](https://img.shields.io/gem/v/rspec-active_model_serializers.svg)](https://rubygems.org/gems/rspec-active_model_serializers)

## Installation

Add **rspec-active_model_serializers** the `:test` group in the _Gemfile_:

```ruby
group :test do
  gem 'rspec-active_model_serializers'
end
```

## Usage

### `have_valid_schema`

Validates the request or response against a [JSON
Schema](http://json-schema.org/). You can customize which schema to use by
chaining `.at_path(path_to_schema)`.

```ruby
# spec/rails_helper.rb
ActiveModelSerializers.config.schema_path = 'spec/support/schemas'
```

```ruby
# spec/controller/posts_controller_spec.rb
Rspec.describe PostsController do
  context 'GET /index' do
    it 'responds with a valid schema' do
      get :index
      # Schema: spec/support/schemas/posts/index.json
      expect(response).to have_valid_schema
    end
  end

  context 'GET /show' do
    it 'responds with a valid schema' do
      get :show, id: 1
      # Schema: spec/support/schemas/custom/show.json
      expect(response).to have_valid_schema.at_path('custom/show.json')
    end
  end
end
```

`expect(response_or_request).to have_valid_schema.at_path(path_to_schema)` can
be understood as being a translation of both
`assert_response_schema(path_to_schema)` and
`assert_request_schema(path_to_schema)`. See
[ActiveModelSerializers::Test::Schema](https://github.com/rails-api/active_model_serializers/blob/master/lib/active_model_serializers/test/schema.rb)
and [RSpec::ActiveModelSerializers::Matchers::HaveValidSchema](lib/rspec/active_model_serializers/matchers/have_valid_schema.rb)
for additional documentation.
