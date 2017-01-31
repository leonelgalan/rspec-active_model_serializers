# frozen_string_literal: true

require File.expand_path('../lib/rspec/active_model_serializers/version',
                         __FILE__)

Gem::Specification.new do |spec|
  spec.name = 'rspec-active_model_serializers'
  spec.version = RSpec::ActiveModelSerializers::VERSION
  spec.authors = ['Leonel Galan']
  spec.email = ['leonelgalan@gmail.com']
  spec.homepage = 'http://github.com/leonelgalan/rspec-active_model_serializers'
  spec.summary = 'RSpec for ActiveModelSerializers'
  spec.description = 'Simple testing of ActiveModelSerializers via a ' \
                     'collection of matchers.'
  spec.license = 'MIT'
  spec.add_runtime_dependency 'active_model_serializers', '~> 0.10.4'
  spec.add_runtime_dependency 'json_schema'
  spec.add_development_dependency 'railties', ['>= 4.1', '< 6']
  spec.add_development_dependency 'rspec', '~> 3.5'
  spec.add_development_dependency 'rspec-rails'
  spec.add_development_dependency 'codeclimate-test-reporter', '>=1.0'
  spec.files = `git ls-files`.split("\n")
  spec.test_files = `git ls-files -- spec/*`.split("\n")
  spec.require_paths = ['lib']
end
