class UserPasswordResetRequest < ApplicationRecord
  validates :email,
    presence: true,
    email: { message: "invalid email format" }


  validate :_validate_email_matches_existing_user

  private

  def _validate_email_matches_existing_user
    return if User.where(email: email).exists?
    errors.add :email, "email must match user"
  end
end
