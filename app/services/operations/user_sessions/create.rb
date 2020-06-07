# frozen_string_literal: true

module Operations
  module UserSessions
    class Create
      include Dry::Monads[:result, :do]

      def call(params)
        user = yield find(params)
        session = yield authenticate(user, params)
        Success(session)
      end

      private

      def find(params)
        email = params.dig(:email).downcase.strip
        user = User.find(email: email)
        user ? Success(user) : Failure(code: :authentication_error, payload: I18n.t("sessions.user.not_found"))
      end

      def authenticate(user, params)
        password = params.dig(:password).strip
        if user.password_valid?(password)
          Success(UserSession.create(user_id: user.id))
        else
          Failure(code: :authentication_error, payload: I18n.t("sessions.user.unauthorized"))
        end
      end
    end
  end
end
