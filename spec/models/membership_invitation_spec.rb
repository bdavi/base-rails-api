require 'rails_helper'

RSpec.describe MembershipInvitation, type: :model do

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

  context "when email matches existing user" do
    it "accepts the invitation after create" do
      user = create(:user)
      subject = build(:membership_invitation, email: user.email)
      expect(subject).to receive(:accept)
      subject.save
    end
  end

end
