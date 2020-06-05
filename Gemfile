# frozen_string_literal: true

source "https://rubygems.org"

git_source(:github) {|repo_name| "https://github.com/#{repo_name}" }

ruby "2.7.1"

gem "dotenv", "~> 2.7.5"
gem "dry-monads", "~> 1.3.5"
gem "dry-validation", "~> 1.5.0"
gem "fast_jsonapi", "~> 1.5"
gem "i18n"
gem "jwt", "~> 2.2.1"
gem "pg", "~> 1.2.3"
gem "puma", "~> 4.3.0"
gem "rake", "~> 13.0.1"
gem "sequel", "~> 5.32.0"

group :test do
  gem "database_cleaner-sequel"
  gem "factory_bot", "~> 5.2.0"
  gem "rspec"
end
