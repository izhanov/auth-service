# frozen_string_literal: true

module Boot
  extend self

  def setup
    connect_to_db
    require_app
    initialize_app
  end

  private

  def connect_to_db
    require_file "config/initializers/db"
  end

  def require_app
    require_file "config/application"
    require_dir "app"
  end

  def initialize_app
    require_dir "config/initializers"
  end

  def require_file(path)
    require File.join(root, path)
  end

  def require_dir(path)
    path = File.join(root, path)
    Dir["#{path}/**/*.rb"].each { |file| require file }
  end

  def root
    File.expand_path("..", __dir__)
  end
end
