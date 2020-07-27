# frozen_string_literal: true

class AuthRoutes < Application
  route do |r|
    r.on "auth" do
      r.on "v1" do
        r.is "sign_up" do
          signup_params = request.params.deep_symbolize_keys

          r.post do
            operation = Operations::Users::Create.new
            result = operation.call(signup_params)

            case result
            when Success
              response.status = 201
              response.finish
            when Failure
              response.status = 422
              result.failure
            end
          end
        end

        r.is "login" do
          login_params = request.params.deep_symbolize_keys

          r.post do
            operation = Operations::UserSessions::Create.new
            result = operation.call(login_params)

            case result
            when Success
              response.status = 201
              response["meta"] = { token: Utils::JWTEncoder.encode(result.value!.uuid) }
              response.finish
            when Failure
              response.status = 401
              result.failure
            end
          end
        end

        r.is "authenticate" do
          auth_header = request.headers["Authorization"]

          r.post do
            operation = Operations::UserSessions::Authenticate.new
            result = operation.call(auth_header)

            case result
            when Success
              response.status = 201
              { meta: { user_id: result.value!.user_id } }
            when Failure
              response.status = 403
              result.failure
            end
          end
        end
      end
    end
  end
end
