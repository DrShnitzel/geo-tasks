# frozen_string_literal: true

ENV['RACK_ENV'] ||= 'development'

require 'bundler'
Bundler.require :default, ENV['RACK_ENV'].to_sym

Dir.glob("#{__dir__}/config/initializers/*.rb").each { |file| require file }
Dir.glob("#{__dir__}/config/*.rb").each { |file| require file }
Dir.glob("#{__dir__}/models/*.rb").each { |file| require file }
require_relative 'errors'
