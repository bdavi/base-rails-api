require "rails_helper"

RSpec.describe V1::UserResource, type: :resource do
  it { is_expected.to have_fetchable_fields :id, :created_at, :updated_at, :email }

  it { is_expected.to have_creatable_fields :email, :password }

  it { is_expected.to have_updatable_fields :email, :password }

  it { is_expected.to have_sortable_fields :id, :created_at, :updated_at, :email }
end
