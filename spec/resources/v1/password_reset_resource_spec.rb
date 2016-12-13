require "rails_helper"

RSpec.describe V1::PasswordResetResource, type: :resource do
  let :creatable_fields do
    %i[old_password new_password user_id]
  end
  let(:updatable_fields) { creatable_fields }
  let(:sortable_fields)  { base_fetchable_fields }
  let(:fetchable_fields) { base_fetchable_fields + creatable_fields }

  it { is_expected.to have_creatable_fields *creatable_fields }

  it { is_expected.to have_no_updatable_fields }

  it { is_expected.to have_no_sortable_fields }

  it { is_expected.to have_fetchable_fields *fetchable_fields }
end
