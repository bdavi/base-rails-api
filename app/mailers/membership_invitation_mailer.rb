class MembershipInvitationMailer < ApplicationMailer
  def invite_user_email(membership_invitation)
    organization = membership_invitation.organization
    @signup_url = "#{ENV["WEB_UI_URL"]}/register?organizationId=#{organization.id}"
    @organization_name = organization.name
    subject = "You've been invited to join #{organization.name} on #{@app_name}"

    mail(to: membership_invitation.email, subject: subject)
  end

  def added_to_new_organization_email(membership_invitation)
    @user = membership_invitation.invited_user
    @organization = membership_invitation.organization
    @login_url = "#{ENV["WEB_UI_URL"]}/login"
    subject = "You've been added to #{ @organization.name } on #{ @app_name }"

    mail(to: membership_invitation.email, subject: subject)
  end
end
