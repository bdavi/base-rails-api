require 'rails_helper'

RSpec.describe UserPolicy, type: :policy do

  context "when user is application admin" do
    before { user.kind = "application_admin" }

    it { is_expected.to permit_action(:create) }
    it { is_expected.to permit_action(:update) }
    it { is_expected.to permit_action(:destroy) }
  end

  context "when user is record" do
    let(:record) { user }

    it { is_expected.to permit_action(:create) }
    it { is_expected.to permit_action(:destroy) }

    context "when update includes kind" do
      before { record.kind = "application_admin"}
      it { is_expected.to forbid_action(:update) }
    end

    context "when update does not include kind" do
      it { is_expected.to permit_action(:update) }
    end
  end

  context "when user is member of same organization" do
    persist_record_and_user

    before do
      organization = create(:organization)
      create(:membership, user: user, organization: organization)
      create(:membership, user: record, organization: organization)
    end

    it { is_expected.to permit_action(:create) }
    it { is_expected.to permit_action(:destroy) }

    context "when update includes kind" do
      before { record.kind = "application_admin"}
      it { is_expected.to forbid_action(:update) }
    end

    context "when update does not include kind" do
      it { is_expected.to permit_action(:update) }
    end
  end

  context "when user is unrelated" do
    it { is_expected.to permit_action(:create) }
    it { is_expected.to forbid_action(:update) }
    it { is_expected.to forbid_action(:destroy) }

    context "scope" do
      it "includes the current user in scope" do
        user.save
        expect(user.memberships).to be_empty
        expect(resolved_scope).to include user
      end
    end
  end

  describe "#scope" do
    persist_record_and_user

    before { create(:membership, user: user, organization: organization) }
    let!(:organization) { create(:organization) }

    let!(:shared_membership) { create(:membership, organization: organization).user }
    let!(:unrelated) { create(:user) }

    context "when non-admin" do
      it "includes the organizations the user is a member of" do
        expect(resolved_scope).to eq [user, shared_membership]
      end
    end

    context "when user is applciation administrator" do
      before { user.update kind: "application_admin" }

      it "includes all organizations" do
        expect(resolved_scope.to_set).to eq User.all.to_set
      end
    end
  end
end
