require 'rails_helper'

RSpec.describe Membership, type: :model do

  it { is_expected.to belong_to :user }

  it { is_expected.to belong_to :organization }

  it { is_expected.to validate_presence_of(:user).with_message("must exist") }

  it { is_expected.to validate_presence_of(:organization).with_message("must exist") }

end
