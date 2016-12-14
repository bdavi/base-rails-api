require 'rails_helper'

RSpec.describe PasswordReset do
  subject { build(:password_reset) }

  it { is_expected.to be_kind_of(JRCreatableServiceObject) }

  describe "#can_perform?" do
    it "is true when initialized correctly" do
      expect(subject.can_perform?).to be_truthy
    end

    it "is false when no user present" do
      subject.user_id = nil
      expect(subject.can_perform?).to be_falsy
    end

    it "is false when no new_password" do
      subject.new_password = nil
      expect(subject.can_perform?).to be_falsy
    end

    it "is false when old_password is incorrect" do
      subject.old_password = "INCORRECT!!!!!!!!"
      expect(subject.can_perform?).to be_falsy
    end
  end

  describe "#perform" do
    it "changes the password" do
      subject.user.save
      subject.perform
      expect(subject.user.authenticate(subject.new_password)).to be_truthy
    end
  end
end
