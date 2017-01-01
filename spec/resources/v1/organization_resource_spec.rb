require "rails_helper"

RSpec.describe V1::OrganizationResource, type: :resource do
  let :creatable_fields do
    %i[name address phone url email memberships users]
  end
  let(:updatable_fields) { creatable_fields }
  let(:sortable_fields)  { base_fetchable_fields + [:name] }
  let(:fetchable_fields) { base_fetchable_fields + creatable_fields }

  it { is_expected.to have_creatable_fields *creatable_fields }

  it { is_expected.to have_updatable_fields *updatable_fields }

  it { is_expected.to have_sortable_fields  *sortable_fields  }

  it { is_expected.to have_fetchable_fields *fetchable_fields }
end
