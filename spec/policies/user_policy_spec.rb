require 'rails_helper'

RSpec.describe UserPolicy, type: :policy do
  context "when user is record" do
    let(:record) { user }

    it { is_expected.to permit_action(:create) }
    it { is_expected.to permit_action(:update) }
    it { is_expected.to permit_action(:destroy) }

    describe "#scope" do
      persist_record_and_user

      it "includes only the authenticated user" do
        expect(subject.scope).to eq [user]
      end
    end
  end

  context "when user and record are different" do
    it { is_expected.to permit_action(:create) }
    it { is_expected.to forbid_action(:update) }
    it { is_expected.to forbid_action(:destroy) }

    describe "#scope" do
      persist_record_and_user

      it "includes only the authenticated user" do
        create(:user)
        expect(subject.scope).to eq [user]
      end
    end
  end
end
