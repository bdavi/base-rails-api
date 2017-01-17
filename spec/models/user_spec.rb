require 'rails_helper'

RSpec.describe User, type: :model do

  it { is_expected.to have_many :memberships }

  it { is_expected.to have_many(:organizations).through(:memberships) }

  it { is_expected.to have_attribute :email }

  it { is_expected.to validate_presence_of :email }

  it "validates email is case insensitive unique" do
    user_to_test_against = FactoryGirl.create(:user)
    is_expected.to validate_uniqueness_of(:email).case_insensitive
  end

  include_examples "validate_format_as_email_of", :email

  it { is_expected.to have_attribute :name }

  it { is_expected.to validate_presence_of :name }

  it { is_expected.to have_secure_password }

  it { is_expected.to have_attribute :kind }

  it "has the expected kinds" do
    expect(described_class.kinds).to eq({ "application_admin" => 0, "standard" => 1 })
  end

  it "defaults kind to standard" do
    expect(described_class.new.kind).to eq "standard"
  end

  describe "#access_token" do
    it "returns an AccessToken for the user" do
      subject.save
      token = subject.access_token
      expect(token).to be_a Doorkeeper::AccessToken
      expect(token.resource_owner_id).to eq subject.id
    end
  end

  describe "on create" do
    it "accepts pending invitations" do
      invitation = create(:membership_invitation)
      subject.email = invitation.email

      expect(invitation.status).to eq "pending"
      expect(subject.organizations).to be_empty

      subject.save
      invitation.reload

      expect(invitation.status).to eq "accepted"
      expect(subject.organizations).to include invitation.organization
    end
  end
end
