require 'rails_helper'

RSpec.describe PasswordReset, type: :model do

  it { is_expected.to be_kind_of(JRCreatableServiceObject) }

  it { is_expected.to validate_presence_of :old_password }

  it { is_expected.to validate_presence_of :new_password }

  it { is_expected.to validate_presence_of :user_id }

  it "validates password is for user" do
    subject.old_password = "INCORRECT!!!!!!!!"
    subject.valid?
    expect(subject.errors[:old_password]).to include "does not match user"
  end

  describe "#perform" do
    it "changes the password" do
      subject.perform
      user = User.find(subject.user_id)
      expect(user.authenticate(subject.new_password)).to be_truthy
    end
  end
end
