# frozen_string_literal: true

RSpec.describe Operations::Users::Create, type: :service do
  describe "#call" do
    context "when params missing" do
      it "returns failure" do
        result = subject.call({})
        expect(result).to be_a(Dry::Monads::Failure)
        expect(result.failure).to include(code: :validation_error)
      end
    end

    context "when params invalid" do
      let(:params) {
        {
          name: "John Doe",
          email: "johndoe@mail.com"
        }
      }
      it "returns failure" do
        result = subject.call(params)
        expect(result).to be_a(Dry::Monads::Failure)
        expect(result.failure).to include(code: :validation_error, payload: {password: ["не может отсутствовать"]})
      end
    end

    context "when params correct" do
      let(:params) {
        {
          name: "John Doe",
          email: "johndoe@mail.com",
          password: "password"
        }
      }
      it "returns success" do
        result = subject.call(params)
        expect(result).to be_a(Dry::Monads::Success)
        expect(result.value!).to be_a(User)
      end
    end
  end
end
