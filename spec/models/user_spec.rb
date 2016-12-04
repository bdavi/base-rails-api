require 'rails_helper'

RSpec.describe User, type: :model do
  describe "#email" do
    it { is_expected.to have_attribute :email }
    it { is_expected.to validate_presence_of :email }
    it "validates email is case insensitive unique" do
      user_to_test_against = FactoryGirl.create(:user)
      is_expected.to validate_uniqueness_of(:email).case_insensitive
    end
    it "validates the format of :email" do
      subject.email = "not an email"
      subject.valid?
      expect(subject.errors[:email]).to include "invalid email format"

      subject.email = "goodemail@address.com"
      subject.valid?
      expect(subject.errors[:email]).to be_empty
    end
  end

  it { is_expected.to have_attribute :name }
  it { is_expected.to validate_presence_of :name }

  it { is_expected.to have_secure_password }
end
