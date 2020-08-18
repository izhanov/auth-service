# frozen_string_literal: true

module Boot
  extend self

  def setup
    connect_to_db
    require_app
    init_app
  end

  private

  def connect_to_db
    require_file "config/initializers/db"
  end

  def require_app
    require_file "config/application"
    require_file "config/initializers/i18n"
    require_file "app/services/operations/users/create"
    require_file "app/services/validations/user/create"
    require_dir "app/services/utils"
    require_dir "app"
  end

  def init_app
    require_file "config/initializers/i18n"
    require_file "config/initializers/dry_validation"
    require_file "config/initializers/consumer"
    require_file "config/initializers/logger"
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
