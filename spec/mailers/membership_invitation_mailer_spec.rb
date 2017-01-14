require "rails_helper"

RSpec.describe MembershipInvitationMailer, type: :mailer do

  before do
    allow(ENV).to receive(:[]).with("WEB_UI_URL").and_return("http://www.somedomain.com")
    allow(Rails.configuration).to receive(:application_display_name).and_return("Some App Name")
  end

  describe "#invite_user" do
    let(:organization) { build(:organization, name: "Acme Inc.", id: 99) }
    let(:invitation) { build(:membership_invitation, organization: organization) }
    let(:mailer) { described_class.invite_user(invitation).deliver_now }

    it "has the expected subject" do
      expect(mailer.subject).to eq "You've been invited to join Acme Inc. on Some App Name"
    end

    it "has the expected to email" do
      expect(mailer.to).to eq([invitation.email])
    end

    it "has the expected from email" do
      expect(mailer.from).to eq([ApplicationMailer.default[:from]])
    end

    it "has the expected body" do
      expected_pieces = [
        "You have been invited to join Acme Inc. on Some App Name",
        'www.somedomain.com\/register\?organizationId=99',
        "The Some App Name Team"
      ]

      expected_pieces.each do |piece|
        expect(mailer.body.encoded).to match(piece)
      end
    end
  end
end
