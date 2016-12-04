require "rails_helper"

RSpec.describe V1::UserPasswordResetRequestResource, type: :resource do
  it { is_expected.to have_creatable_fields :email }

  it { is_expected.to have_no_updatable_fields }

  it { is_expected.to have_no_sortable_fields }

  it { is_expected.to have_no_fetchable_fields }
end
