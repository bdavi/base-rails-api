class MembershipInvitationMailer < ApplicationMailer

  def invite_user(membership_invitation)
    organization = membership_invitation.organization
    @signup_url = "#{ENV["WEB_UI_URL"]}/register?organizationId=#{organization.id}"
    @app_name = Rails.configuration.application_display_name
    @organization_name = organization.name
    subject = "You've been invited to join #{organization.name} on #{@app_name}"

    mail(to: membership_invitation.email, subject: subject)
  end

end
