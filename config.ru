# frozen_string_literal: true

require_relative "config/environment"

map "/auth" do
  run Application.new
end
