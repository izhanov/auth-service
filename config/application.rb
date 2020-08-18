# frozen_string_literal: true

class Application < Roda
  opts[:root] = File.expand_path("..", __dir__)

  plugin :json
  plugin :all_verbs
  plugin :param_matchers
  plugin :request_headers
  plugin :environments

  configure :development, :test do
    opts[:logger] = Ougai::Logger.new(
      STDOUT,
      level: "info"
    )

    opts[:logger].before_log = lambda { |data| data[:service] = {name: "auth"}}

    opts[:logger].formatter = Ougai::Formatters::Readable.new
  end

  configure :production do |app|
    opts[:logger] = Ougai::Logger.new(
      app.root.concat("/", ENV["LOGGER_PATH"]),
      level: "info"
    )
  end

  include Dry::Monads[:result]
end
