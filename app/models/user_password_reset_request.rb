class UserPasswordResetRequest < ApplicationRecord
  validates :email,
    presence: true,
    email: { message: "invalid email format" }
end
