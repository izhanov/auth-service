# frozen_string_literal: true

require "spec_helper"

ENV["RACK_ENV"] ||= "test"

require_relative "../config/environment"

abort("You run tests in production mode. Please don\'t do this!") if ENV["RACK_ENV"] == "production"
Dir[File.join(Application.opts[:root], "spec/support/**/*.rb")].sort.each { |file| require file }

RSpec.configure do |config|
  config.include Rack::Test::Methods
  config.include Features::RouteHelpers
end
