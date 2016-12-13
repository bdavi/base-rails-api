class UserMailer < ApplicationMailer
  def password_reset_email(user)
    @user = user
    @reset_url = "#{ENV["WEB_UI_URL"]}/reset_password?authToken=#{user.access_token.token}"
    @app_name = Rails.configuration.application_display_name
    subject = "#{@app_name} Password Reset"

    mail(to: @user.email, subject: subject)
  end
end