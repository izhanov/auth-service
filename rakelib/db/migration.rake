# frozen_string_literal: true

namespace :db do
  desc "Create migration template for Sequel"

  task :migration, %i[name] => :environment do |t, args|
    timestamp = Time.now.strftime("%Y%m%d%H%M%S")
    migration = File.open("./db/migrate/#{timestamp}_#{args.name}.rb", "w")
    migration.write "Sequel.migration do\n\tchange do\n\tend\nend\n"
    migration.close
  end
end
