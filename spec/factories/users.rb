# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    name { Faker::Name.name }
    sequence(:email) { |n| "#{name}#{n}@mail.com" }
    password_digest { "password" }
  end
end
