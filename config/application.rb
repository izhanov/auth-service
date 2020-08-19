# frozen_string_literal: true

class Application < Roda
  opts[:root] = File.expand_path("..", __dir__)

  plugin :json
  plugin :all_verbs
  plugin :param_matchers
  plugin :request_headers
  plugin :environments

  configure :test do
    opts[:logger] = Ougai::Logger.new(
      STDOUT,
      level: "info"
    )

    opts[:logger].before_log = lambda do |data|
      data[:service] = { name: "auth" }
    end

    opts[:logger].formatter = Ougai::Formatters::Readable.new
  end

  configure :production, :development do |app|
    opts[:logger] = Ougai::Logger.new(
      "#{app.opts[:root]}/#{ENV['LOGGER_PATH']}",
      level: "info"
    )
    opts[:logger].before_log = lambda do |data|
      data[:service] = { name: "auth" }
    end
  end

  include Dry::Monads[:result]
end
