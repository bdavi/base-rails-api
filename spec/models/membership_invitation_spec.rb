require 'rails_helper'

RSpec.describe MembershipInvitation, type: :model do
  include_examples "TextSearchable", %i[email user.name]

  it { is_expected.to have_attribute :email }

  it { is_expected.to belong_to :user }

  it { is_expected.to belong_to :membership }

  it { is_expected.to belong_to :organization }

  it { is_expected.to validate_presence_of :email }

  it { is_expected.to validate_presence_of :user }

  it { is_expected.to validate_presence_of :organization }

  include_examples "validate_format_as_email_of", :email

  describe "#accept" do
    it "creates a membership and sets that value on the invitation" do
      user = create(:user)
      subject = build(:membership_invitation, email: user.email)

      expect(subject.membership).to be_nil
      expect { subject.accept }.to change { Membership.count }.by(1)
      expect(user.organizations).to include subject.organization
      subject.reload
      expect(subject.membership).to eq user.memberships.first
    end
  end

  context "after_create" do
    context "when email matches existing user" do
      let(:invited_user) { create(:user) }
      subject { build(:membership_invitation, email: invited_user.email) }

      it "accepts the invitation after create" do
        expect(subject).to receive(:accept)
        subject.save
      end

      it "sends an email to the invited user" do
        expect(MembershipInvitationMailer).to receive(:added_to_new_organization_email)
          .with(subject).and_call_original

        expect {
          subject.save
        }.to change { ActionMailer::Base.deliveries.count }.by(1)
      end
    end

    context "when no matching invited user" do
      it "sends an email to the specified email" do
        expect(MembershipInvitationMailer).to receive(:invite_user_email)
          .with(subject).and_call_original

        expect {
          subject.save
        }.to change { ActionMailer::Base.deliveries.count }.by(1)
      end
    end
  end

  describe "#status" do
    context "when not accepted and after expiration date" do
      it "returns 'expired'" do
        subject.created_at = (described_class::EXPIRATION_INTERVAL_DAYS + 1).days.ago
        expect(subject.status).to eq "expired"
      end
    end

    context "when not accepted and before expiration date" do
      it "returns 'pending'" do
        subject.created_at = DateTime.now
        expect(subject.status).to eq "pending"
      end
    end

    context "when membership is present" do
      it "returns 'accepted'" do
        subject.membership = Membership.new
        expect(subject.status).to eq "accepted"
      end
    end
  end

end
