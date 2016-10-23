require 'rails_helper'

RSpec.describe UserPolicy, type: :policy do
  it { is_expected.to permit_action(:create) }

  context "when user is record" do
    let(:record) { user }

    it { is_expected.to permit_action(:update) }
    it { is_expected.to permit_action(:destroy) }

    describe "#scope" do
      persist_record_and_user

      it "includes only the authenticated user" do
        create(:user)
        expect(resolved_scope).to eq [user]
      end
    end
  end

  context "when user and record are different" do
    it { is_expected.to forbid_action(:update) }
    it { is_expected.to forbid_action(:destroy) }

    describe "#scope" do
      persist_record_and_user

      it "includes only the authenticated user" do
        expect(resolved_scope).to eq [user]
      end
    end
  end
end
