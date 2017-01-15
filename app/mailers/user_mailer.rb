class UserMailer < ApplicationMailer
  def password_reset_email(user)
    @user = user
    @reset_url = "#{ENV["WEB_UI_URL"]}/user-profile/reset-password?authToken=#{user.access_token.token}"
    subject = "#{@app_name} Password Reset"

    mail(to: @user.email, subject: subject)
  end
end
