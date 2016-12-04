class UserMailerPreview < ActionMailer::Preview
  def password_reset_email
    UserMailer.password_reset_email(User.first)
  end
end
