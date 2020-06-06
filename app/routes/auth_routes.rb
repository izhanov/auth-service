# frozen_string_literal: true

class AuthRoutes < Application
  route do |r|
    r.on "auth" do
      r.on "v1" do
        r.is "login" do
          r.post do
            {hello: "world"}
          end
        end
      end
    end
  end
end
