# frozen_string_literal: true

module Operations
  module Users
    class Create
      include Dry::Monads[:result, :do]

      def call(params)
        validated_params = yield validate(params)
        resource = yield commit(validated_params.to_h)
        Success(resource)
      end

      private

      def validate(params)
        operation = Validations::User::Create.new
        operation.call(params).to_monad
      end

      def commit(params)
        name = params.dig(:name)
        email = params.dig(:email)
        password = params.dig(:password)

        resource = User.create(name: name, email: email, password_digest: password)
        Success(resource)
      rescue Sequel::UniqueConstraintViolation
        Failure(code: :not_unique, payload: I18n.t("user.not_unique"))
      end
    end
  end
end
