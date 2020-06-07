# frozen_string_literal: true

require "i18n"

module Validations
  module User
    class Create < Dry::Validation::Contract
      config.messages.backend = :yaml
      config.messages.default_locale = :ru
      config.messages.load_paths << "#{Application.opts[:root]}/config/locales/errors/errors.en.yml"
      config.messages.load_paths << "#{Application.opts[:root]}/config/locales/errors/errors.ru.yml"

      params do
        required(:name).filled(:string)
        required(:email).filled(:string)
        required(:password).filled(:string)
      end

      rule(:email) do
        unless /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i.match?(value)
          key.failure(:email_format)
        end
      end

      rule(:password) do
        key.failure(:password_min_size?) if value.length < 6
      end
    end
  end
end
