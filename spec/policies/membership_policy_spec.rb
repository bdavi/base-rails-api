require 'rails_helper'

RSpec.describe MembershipPolicy, type: :policy do

  context "when user is application admin" do
    before { user.kind = "application_admin" }

    it { is_expected.to permit_action(:create) }
    it { is_expected.to forbid_action(:update) }
    it { is_expected.to permit_action(:destroy) }
  end

  context "when user is member of organization" do
    before { record.organization.users << user }

    it { is_expected.to permit_action(:create) }
    it { is_expected.to forbid_action(:update) }
    it { is_expected.to permit_action(:destroy) }
  end

  context "when user is unrelated" do
    it { is_expected.to forbid_action(:create) }
    it { is_expected.to forbid_action(:update) }
    it { is_expected.to forbid_action(:destroy) }
  end

  describe "#scope" do
    persist_record_and_user

    let!(:member_of) { record.tap { record.update user: user }}
    let!(:unrelated) { create(:membership) }

    context "when non-admin" do
      it "includes the organizations the user is a member of" do
        expect(resolved_scope).to eq [member_of]
      end
    end

    context "when user is applciation administrator" do
      before { user.update kind: "application_admin" }

      it "includes all organizations" do
        expect(resolved_scope.to_set).to eq Membership.all.to_set
      end
    end
  end
end
