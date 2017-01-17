require "rails_helper"

RSpec.describe MembershipInvitationMailer, type: :mailer do
  before do
    allow(ENV).to receive(:[]).with("WEB_UI_URL").and_return("http://www.somedomain.com")
    allow(Rails.configuration).to receive(:application_display_name).and_return("Some App Name")
  end

  let(:organization) { build(:organization, name: "Acme Inc.", id: 99) }
  let(:invitation) do
    build(:membership_invitation, organization: organization, email: "test@test.com")
  end

  describe "#invite_user_email" do
    let(:mailer) { described_class.invite_user_email(invitation).deliver_now }

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
        '<a href="http://www.somedomain.com/redeem-invitation?organizationId=99' +
          '&amp;organziationName=Acme%20Inc.&amp;email=test@test.com">Click here</a>',
        "The Some App Name Team"
      ]

      expected_pieces.each do |piece|
        expect(mailer.body.encoded).to include(piece)
      end
    end
  end

  describe "#added_to_new_organization_email" do
    let(:mailer) { described_class.added_to_new_organization_email(invitation).deliver_now }
    let!(:invited_user) { create(:user, name: "Count Dracula", email: invitation.email) }

    it "has the expected subject" do
      expect(mailer.subject).to eq "You've been added to Acme Inc. on Some App Name"
    end

    it "has the expected to email" do
      expect(mailer.to).to eq([invitation.email])
    end

    it "has the expected from email" do
      expect(mailer.from).to eq([ApplicationMailer.default[:from]])
    end

    it "has the expected body" do
      expected_pieces = [

        "Hello Count Dracula,",
        "You have been added to Acme Inc. on Some App Name",
        "The Some App Name Team"
      ]

      expected_pieces.each do |piece|
        expect(mailer.body.encoded).to match(piece)
      end
    end
  end
end
