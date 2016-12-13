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
    it "raises JSONAPI::Exceptions::InternalServerError unless #can_perform?" do
      allow(subject).to receive(:can_perform?).and_return(false)
      expect{ subject.perform }.to raise_error(JSONAPI::Exceptions::InternalServerError)
    end

    it "changes the password when #can_perform?" do
      subject.user.save
      subject.perform
      expect(subject.user.authenticate(subject.new_password)).to be_truthy
    end
  end
end
