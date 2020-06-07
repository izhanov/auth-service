# frozen_string_literal: true

class Application < Roda
  opts[:root] = File.expand_path("..", __dir__)

  plugin :json
  plugin :all_verbs
  plugin :param_matchers

  include Dry::Monads[:result]
end
