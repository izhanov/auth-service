# frozen_string_literal: true

RSpec.describe AuthRoutes, type: :routes do
  describe "POST /auth/v1/sign_up" do
    context "missing params" do
      let(:params) {
        { name: "John Doe", email: "johndoe@gmail.com", password: "" }
      }
      it "returns an error" do
        post "/auth/v1/sign_up", params

        expect(response.status).to eq(422)
        expect(response.body).to include(
          {
            code: "validation_error",
            payload: {
              password: ["не может быть пустым"]
            }
          }
        )
      end
    end

    context "invalid params" do
      let(:params) {
        { name: "John Doe", email: "johndoe@gmailcom", password: "12345" }
      }
      it "returns an error" do
        post "/auth/v1/sign_up", params

        expect(response.status).to eq(422)
        expect(response.body).to include(
          {
            code: "validation_error",
            payload: {
              email: ["Не верный формат"],
              password: ["Пароль не должен быть меньше 6 символов"]
            }
          }
        )
      end
    end

    context "valid params" do
      let(:params) {
        { name: "John Doe", email: "johndoe@gmail.com", password: "password" }
      }
      it "returns status created" do
        post "/auth/v1/sign_up", params

        expect(response.status).to eq(201)
      end
    end
  end

  describe "POST /auth/v1/login" do
    context "when user's email don't exist" do
      let!(:user) { create(:user) }
      let(:params) { { email: "foreigner@mail.com", password: "pasword" } }

      it "returns 401 Unauthorized" do
        post "/auth/v1/login", params
        expect(response.status).to eq(401)
        expect(response.body).to include(
          {
            code: "authentication_error",
            payload: "Пользователь с данным email не зарегистрирован"
          }
        )
      end
    end

    context "when user's password invalid" do
      let!(:user) { create(:user) }
      let(:params) { { email: user.email, password: "pasword" } }
      it "returns 401 Unauthorized" do
        post "/auth/v1/login", params

        expect(response.status).to eq(401)
        expect(response.body).to include(
          {
            code: "authentication_error",
            payload: "Сессия не может быть создана"
          }
        )
      end
    end

    context "when user's password and emal valid" do
      let(:token) { "jwt_token" }

      before do
        create(:user, email: "johndoe@mail.com", password_digest: "password")
        allow(JWT).to receive(:encode).and_return(token)
      end

      it "returns 200 with token" do
        post "/auth/v1/login", { email: "johndoe@mail.com", password: "password" }

        expect(response.status).to eq(201)
        expect(response.headers["meta"]).to eq(token: token)
      end
    end
  end

  describe "POST /auth/v1/authenticate" do
    context "when token is missing" do
      it "returns 403 error" do
        post "/auth/v1/authenticate"
        expect(response.status).to eq(403)
        expect(response.body).to include(
          {
            code: "authentication_error",
            payload: "Отсутствует заголовок авторизации"
          }
        )
      end
    end

    context "when user's token invalid" do
      it "returns 403 error" do
        header "Authorization", "Bearer invalid token"
        post "/auth/v1/authenticate"
        expect(response.status).to eq(403)
        expect(response.body).to include(
          {
            code: "authentication_error",
            payload: "Неверный формат токена"
          }
        )
      end
    end

    context "when user's token valid" do
      let!(:user) { create(:user) }
      let!(:session) { create(:user_session, user: user) }

      before do
        allow(JWT).to receive(:decode).and_return([session.uuid])
      end

      it "returns user's ID" do
        header "Authorization", "Bearer valid token"
        post "/auth/v1/authenticate"
        expect(response.status).to eq(201)
        expect(response.body).to include( meta: { user_id: user.id } )
      end
    end
  end
end
