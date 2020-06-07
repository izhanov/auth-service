# frozen_string_literal: true

RSpec.describe Validations::User::Create, type: :service do
  it "requires name" do
    expect(subject.call(email: "johndoe@mailcom").errors.to_h).to include(name: ["не может отсутствовать"])
  end

  it "requires email" do
    expect(subject.call(name: "John Doe").errors.to_h).to include(email: ["не может отсутствовать"])
  end

  it "expect email to follow specific pattern" do
    expect(subject.call(name: "John Doe", email: "johndoemail.com").errors.to_h).to include(email: ["Не верный формат"])
  end

  it "requires password" do
    expect(subject.call(name: "John Doe", email: "johndoe@mail.com").errors.to_h).to include(password: ["не может отсутствовать"])
  end

  it "expect password to follow min size" do
    expect(subject.call(name: "John Doe", email: "johndoe@mail.com", password: "12345").errors.to_h).to include(password: ["Пароль не должен быть меньше 6 символов"])
  end
end
