# frozen_string_literal: true

class User < Sequel::Model
  one_to_many :sessions, class: :UserSession
  include BCrypt

  def before_create
    self.email = email.downcase.strip
    self.password_digest = BCrypt::Password.create(password_digest.strip)
    super
  end

  def password_valid?(password)
    Password.new(password_digest) == password
  end
end
