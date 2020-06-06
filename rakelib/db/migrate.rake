# frozen_string_literal: true

namespace :db do
  desc "Run database migrations"

  task :migrate, %i[version] => :environment do |t, args|
    require "sequel/core"
    Sequel.extension :migration

    Sequel.connect(ENV["DATABASE_URL"]) do |db|
      migrations = File.expand_path("../../db/migrate", __dir__)
      version = args.version.to_i if args.version

      Sequel::Migrator.run(db, migrations, target: version)

      # Create db/schema.rb after run migrations
      `bin/sequel -D #{ENV["DATABASE_URL"]} > ./db/schema.rb`
    end
  end
end
