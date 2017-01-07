# == Schema Information
#
# Table name: user_password_reset_requests
#
#  id         :integer          not null, primary key
#  email      :citext           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class UserPasswordResetRequest < ApplicationRecord
  validates :email,
    presence: true,
    email: { message: "invalid email format" }

  validate :_validate_email_matches_existing_user

  after_commit :_send_email, on: :create

  private

  def _user
    User.find_by(email: email)
  end

  def _validate_email_matches_existing_user
    return if _user
    errors.add :email, "email must match user"
  end

  def _send_email
    UserMailer.password_reset_email(_user).deliver_now
  end
end
