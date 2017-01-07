require 'rails_helper'

RSpec.describe MembershipInvitation, type: :model do

  it { is_expected.to have_attribute :email }

  it { is_expected.to belong_to :user }

  it { is_expected.to belong_to :membership }

  it { is_expected.to belong_to :organization }

  it { is_expected.to validate_presence_of :email }

  it { is_expected.to validate_presence_of :user }

  it { is_expected.to validate_presence_of :organization }

  include_examples "validate_format_as_email_of", :email

end
