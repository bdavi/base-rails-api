# Preview all emails at http://localhost:3000/rails/mailers/membership_invitation_mailer
class MembershipInvitationMailerPreview < ActionMailer::Preview
  def invite_user
    MembershipInvitationMailer.invite_user(MembershipInvitation.first)
  end
end
