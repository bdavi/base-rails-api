require 'rails_helper'
require 'rspec_api_documentation/dsl'

RSpec.resource "MembershipInvitation" do
  shared_context "params" do
    parameter "email", scope: :attributes
    parameter "user", scope: :relationships
    parameter "membership", scope: :relationships
    parameter "organization", scope: :relationships
  end

  show
  index
  destroy
  create do
    let("email") { "test@example.com" }
    let("user") do
      {
        data: {
          id: create(:user).id,
          type: "users"
        }
      }
    end
    let("organization") do
      {
        data: {
          id: create(:organization).id,
          type: "organizations"
        }
      }
    end
  end
  update do
    let("email") { "some-new-email@example.com" }
  end

  context "filter by organization" do
    filtered_index :organization, 9999 do
      let!(:included_organization) { create(:organization, id: 9999) }
      let!(:matching_record) { create(:membership_invitation, organization: included_organization) }
      let!(:not_matching_record) { create(:membership_invitation) }
    end
  end

  context "text search" do
    filtered_index :search_by, "Ail@Te"  do
      let!(:matching_record) { create(:membership_invitation, email: "sample_email@test.com") }
      let!(:not_matching_record) { create(:membership_invitation) }
    end
  end
end
