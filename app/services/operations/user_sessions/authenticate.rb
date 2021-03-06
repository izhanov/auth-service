# frozen_string_literal: true

module Operations
  module UserSessions
    class Authenticate
      include Dry::Monads[:result, :do]

      def call(token)
        decoded_token = yield decode(token)
        session = yield find_session(decoded_token)
        Success(session)
      end

      private

      def decode(token)
        decoded_token = Utils::JWTEncoder.decode(token)
        Success(decoded_token)
      rescue JWT::DecodeError
        Failure(code: :authentication_error, payload: I18n.t("sessions.token.invalid"))
      end

      def find_session(token)
        session = UserSession.find(uuid: token)
        session ? Success(session) : Failure(code: :authentication_error, payload: I18n.t("sessions.token.not_found"))
      end
    end
  end
end
