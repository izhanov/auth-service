# frozen_string_literal: true

require_relative "config/environment"
require "rack/unreloader"
dev = ENV["RACK_ENV"] == "development"
Unreloader = Rack::Unreloader.new(subclasses: %w[Roda Sequel::Model]){AuthRoutes}

Unreloader.require "config/application"
Unreloader.require "app/models/*.rb"
Unreloader.require "app/routes/*.rb"

run(dev ? Unreloader : AuthRoutes.freeze.app)
