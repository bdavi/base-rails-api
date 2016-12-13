require 'rails_helper'

RSpec.describe PasswordResetPolicy, type: :policy do
  context "when changing current user's password" do
    before do
      user.save
      record.user_id = user.id
    end

    it { is_expected.to permit_action(:create) }
  end

  context "when changing another user's password" do
    it { is_expected.to forbid_action(:create) }
  end
end
