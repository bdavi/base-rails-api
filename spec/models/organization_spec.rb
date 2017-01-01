require 'rails_helper'

RSpec.describe Organization, type: :model do
  include_examples "TextSearchable", [:name, :address, :phone, :url, :email]

  it { is_expected.to have_attribute :name }

  it { is_expected.to have_attribute :address }

  it { is_expected.to have_attribute :phone }

  it { is_expected.to have_attribute :url }

  it { is_expected.to have_attribute :email }

  it { is_expected.to have_many :memberships }

  it { is_expected.to have_many(:users).through(:memberships) }

  it { is_expected.to validate_presence_of :name }

  it "validates the format of :email" do
    subject.email = "not an email"
    subject.valid?
    expect(subject.errors[:email]).to include "invalid email format"

    subject.email = "goodemail@address.com"
    subject.valid?
    expect(subject.errors[:email]).to be_empty
  end

  it { is_expected.to allow_value("", nil).for(:email) }

  it "normalizes the phone before validation" do
    subject.phone = "970-356-1234"
    subject.valid?
    expect(subject.phone).to eq "+19703561234"
  end

  it "validates the format of :phone" do
    subject.phone = "not a phone"
    subject.valid?
    expect(subject.errors[:phone]).to include "is invalid"

    subject.phone = "970-356-1234"
    subject.valid?
    expect(subject.errors[:phone]).to be_empty
  end

  it { is_expected.to allow_value("", nil).for(:phone) }

  it "validates the format of :url" do
    subject.url = "not a url"
    subject.valid?
    expect(subject.errors[:url]).to include "is invalid"

    subject.url = "http://www.google.com"
    subject.valid?
    expect(subject.errors[:url]).to be_empty
  end

  it { is_expected.to allow_value("", nil).for(:url) }

  it "normalizes the url before validation" do
    subject.url = "www.google.com"
    subject.valid?
    expect(subject.url).to eq "http://www.google.com"
  end
end
