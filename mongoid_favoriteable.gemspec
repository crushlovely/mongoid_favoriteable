# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'mongoid_favoriteable/version'

Gem::Specification.new do |spec|
  spec.name        = 'mongoid_favoriteable'
  spec.version     = MongoidFavoriteable::VERSION
  spec.authors     = ['Greg Morrison']
  spec.email       = ['greg@crushlovely.com']
  spec.homepage    = 'https://github.com/crushlovely/mongoid_favoriteable'
  spec.summary     = 'Favoriting functionality for your Mongoid models'
  spec.description = 'Favoriting functionality for your Mongoid models'

  spec.files         = `git ls-files`.split("\n")
  spec.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  spec.executables   = `git ls-files -- bin/*`.split("\n").collect { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_development_dependency 'bundler'
  spec.add_development_dependency 'pry'
  spec.add_development_dependency 'rake'
  spec.add_development_dependency 'rspec'
  spec.add_development_dependency 'rubocop'
  spec.add_development_dependency 'guard'
  spec.add_development_dependency 'guard-rspec'
  spec.add_development_dependency 'guard-rubocop'
  spec.add_development_dependency 'codeclimate-test-reporter'

  spec.add_dependency 'activesupport', '>=2.1.0'
  spec.add_runtime_dependency 'mongoid'
end
