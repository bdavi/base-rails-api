require 'rails_helper'

RSpec.describe UserPasswordResetRequest, type: :model do
  it { is_expected.to have_attribute :email }

  it { is_expected.to validate_presence_of :email }

  it "validates the format of :email" do
    subject.email = "not an email"
    subject.valid?
    expect(subject.errors[:email]).to include "invalid email format"

    subject.email = "goodemail@address.com"
    subject.valid?
    expect(subject.errors[:email]).to_not include "invalid email format"
  end

  context "when email has a matching user" do
    it "is valid" do
      user = create(:user)
      subject.email = user.email

      expect(subject).to be_valid
    end
  end

  context "when email has not matching user" do
    it "is invalid" do
      subject.email = "not_match@example.com"
      subject.valid?

      expect(subject.errors[:email]).to include "email must match user"
    end
  end
end
