$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)

require 'codeclimate-test-reporter'
CodeClimate::TestReporter.start

require 'rspec'
require 'byebug'
require 'mongoid_favoriteable'

Dir["#{File.dirname(__FILE__)}/support/**/*.rb"].each { |f| require f }

Mongoid.load!('./spec/config/mongoid.yml', :development)

RSpec.configure do |config|
end