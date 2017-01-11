# frozen_string_literal: true

ENV['RACK_ENV'] = 'test'
require_relative '../app'

RSpec.configure do |config|
  config.include FactoryGirl::Syntax::Methods
  config.include Rack::Test::Methods

  config.before(:suite) do
    FactoryGirl.find_definitions
  end
end

def app
  GeoTasksApp
end
