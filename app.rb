# frozen_string_literal: true

ENV['RACK_ENV'] ||= 'development'

require 'bundler'
Bundler.require :default, ENV['RACK_ENV'].to_sym

Dir.glob("#{__dir__}/config/initializers/*.rb").each { |file| require file }
Dir.glob("#{__dir__}/config/*.rb").each { |file| require file }
Dir.glob("#{__dir__}/models/*.rb").each { |file| require file }
Dir.glob("#{__dir__}/routes/*.rb").each { |file| require file }
require_relative 'errors'

class GeoTasksApp < Sinatra::Base
  set :show_exceptions, false

  before do
    content_type 'application/json'
  end

  helpers GeoTasks::Routing::Helper

  register GeoTasks::Routing::Tasks
  register GeoTasks::Routing::Errors
end
