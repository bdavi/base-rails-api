require 'rails_helper'

RSpec.describe UserPasswordResetRequestPolicy, type: :policy do
  context "when user present" do
    it { is_expected.to permit_action(:create) }
  end

  context "when no user present" do
    let(:user) { nil }
    it { is_expected.to permit_action(:create) }
  end

  it { is_expected.to forbid_action(:update) }
  it { is_expected.to forbid_action(:destroy) }

  describe "#scope" do
    persist_record_and_user

    it "does not include the record" do
      expect(resolved_scope).to eq []
    end
  end
end
