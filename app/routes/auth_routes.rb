# frozen_string_literal: true

class AuthRoutes < Application
  route do |r|
    r.on "auth" do
      r.on "v1" do
        r.is "sign_up" do
          r.post do
            operation = Operations::Users::Create.new
            result = operation.call(request.params)

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
          r.post do
            operation = Operations::UserSessions::Create.new
            result = operation.call(request.params.deep_symbolize_keys)

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
      end
    end
  end
end
