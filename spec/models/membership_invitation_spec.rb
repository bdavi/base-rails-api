require 'rails_helper'

RSpec.describe MembershipInvitation, type: :model do
  include_examples "TextSearchable", %i[email user.name]

  it { is_expected.to have_attribute :email }

  it { is_expected.to have_attribute :status }

  it { is_expected.to belong_to :user }

  it { is_expected.to belong_to :organization }

  it { is_expected.to validate_presence_of :email }

  it { is_expected.to validate_presence_of :user }

  it { is_expected.to validate_presence_of :organization }

  include_examples "validate_format_as_email_of", :email

  it "has the expected statuses" do
    expected = {
      "pending" => 0,
      "accepted" => 1,
      "expired" => 2
    }

    expect(described_class.statuses).to eq expected
  end

  it "defaults status to 'pending'" do
    expect(described_class.new.status).to eq "pending"
  end

  it "validates the invited user does not already have a membership" do
    invited_user = create(:user, email: subject.email)
    invited_user.memberships.create(organization: subject.organization)
    subject.valid?

    expect(subject.errors[:email]).to include "A user with this email already has a membership with the organization."
  end

  describe "#accept" do
    it "creates a membership and updates the status to accepted" do
      subject = create(:membership_invitation)
      expect(subject.status).to eq "pending"
      user = create(:user, email: subject.email)
      expect { subject.accept }.to change { Membership.count }.by(1)
      expect(user.organizations).to include subject.organization
      expect(subject.status).to eq "accepted"
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
        }.to enqueue_job(ActionMailer::DeliveryJob)
      end
    end

    context "when no matching invited user" do
      it "sends an email to the specified email" do
        expect(MembershipInvitationMailer).to receive(:invite_user_email)
          .with(subject).and_call_original

        expect {
          subject.save
        }.to enqueue_job(ActionMailer::DeliveryJob)
      end

      it "enqueues an MembershipInvitationExpirationJob" do
        scheduled_expiration = 99.days.from_now
        allow_any_instance_of(ActiveSupport::Duration).to receive(:from_now).and_return(scheduled_expiration)

        expect {
          subject.save
        }.to enqueue_job(MembershipInvitationExpirationJob).at(scheduled_expiration)
      end
    end
  end

  it "validates there is no existing pending invitation to the organization" do
    existing_invitation = create(:membership_invitation, :pending)
    subject.email = existing_invitation.email
    subject.organization = existing_invitation.organization

    subject.valid?

    expect(subject.errors[:email]).to include "already has a pending invitation to this organization"
  end
end
