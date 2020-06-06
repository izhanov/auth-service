# frozen_string_literal: true

task :environment do
  require "dotenv"
  ENV["RACK_ENV"] ||= "development"
  Dotenv.load(".env.#{ENV['RACK_ENV']}", ".env")
end
