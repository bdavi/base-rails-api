require 'activevalidators'

class User < ApplicationRecord
  has_secure_password

  validates :email,
    presence: true,
    uniqueness: { case_insensitive: false },
    email: { message: "invalid email format" }
end
