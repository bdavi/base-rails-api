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
    expect(subject.errors[:email]).to be_empty
  end
end
