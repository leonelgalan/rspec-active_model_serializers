# rspec-active_model_serializers

## Installation

Add `rspec-active_model_serializers` the `:development` group in the _Gemfile_:

```ruby
group :test do
  gem 'rspec-active_model_serializers'
end
```

## Usage

**rspec-active_model_serializers** provides a `have_valid_schema` matcher to be
used on your controller/request specs to validate the response against a [JSON
Schema](http://json-schema.org/). Let's look at the equivalent setup for the
example above.

```ruby
# spec/controller/posts_controller_spec.rb
Rspec.describe PostsController do
  describe 'index' do
    it 'should render right response' do
      get :index
      expect(response).to have_valid_schema
    end
  end
end
```

Its usage is on par with `assert_response_schema`. See
[ActiveModelSerializers::Test::Schema](https://github.com/rails-api/active_model_serializers/tree/master/lib/active_model_serializers/test/schema.rb)
and
[RSpec::ActiveModelSerializers::Matchers::HaveValidSchema](lib/rspec/active_model_serializers/matchers/have_valid_schema.rb)
for more examples and documentation.
