# Preview all emails at http://localhost:3000/rails/mailers/membership_invitation_mailer
class MembershipInvitationMailerPreview < ActionMailer::Preview
  def invite_user_email
    MembershipInvitationMailer.invite_user_email(MembershipInvitation.first)
  end

  def added_to_new_organization_email
    MembershipInvitationMailer.added_to_new_organization_email(MembershipInvitation.first)
  end
end
