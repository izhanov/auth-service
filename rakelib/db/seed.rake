# frozen_string_literal: true

namespace :db do
  desc "Run database seeds"

  task :seed do
    require_relative "../../config/environment"
    [
      ["John Doe", "johndoe@mail.com", "password"],
      ["Joe Doe", "joedoe@mail.com", "password"],
      ["Jane Doe", "janedoe@mail.com", "password"],
      ["Jake Doe", "jakedoe@mail.com", "password"]
    ].each do |(name, email, password)|
      User.create(
        name: name,
        email: email,
        password_digest: password
      )
    end
  end
end
