require 'rails_helper'

RSpec.describe OrganizationPolicy, type: :policy do

  context "when user is application admin" do
    before { user.kind = "application_admin" }

    it { is_expected.to permit_action(:create) }
    it { is_expected.to permit_action(:update) }
    it { is_expected.to permit_action(:destroy) }
  end

  context "when user is member of organization" do
    before { user.organizations << record }

    it { is_expected.to permit_action(:create) }
    it { is_expected.to permit_action(:update) }
    it { is_expected.to permit_action(:destroy) }
  end

  context "when user is unrelated" do
    it { is_expected.to permit_action(:create) }
    it { is_expected.to forbid_action(:update) }
    it { is_expected.to forbid_action(:destroy) }
  end

  describe "#scope" do
    persist_record_and_user

    let!(:member_of) { record.tap { record.update users: [user] }}
    let!(:unrelated) { create(:organization) }

    context "when non-admin" do
      it "includes the organizations the user is a member of" do
        expect(resolved_scope).to eq [member_of]
      end
    end

    context "when user is applciation administrator" do
      before { user.update kind:  "application_admin" }

      it "includes all organizations" do
        expect(resolved_scope.to_set).to eq Organization.all.to_set
      end
    end
  end
end
