require 'rails_helper'

RSpec.describe MembershipInvitationExpirationJob, type: :job do
  let!(:membership_invitation) { create(:membership_invitation) }

  describe "#perform" do
    context "when the invitation is pending" do
      it "updates the status to 'expired'" do
        expect {
          subject.perform membership_invitation
        }.to change { membership_invitation.status }.to "expired"
      end
    end

    context "when the invitation is accepted" do
      it "does not change the status" do
        membership_invitation.update status: "accepted"
        expect {
          subject.perform membership_invitation
        }.to_not change { membership_invitation.status }
      end
    end
  end
end
