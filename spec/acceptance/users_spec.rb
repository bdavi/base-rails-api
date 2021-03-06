require 'rails_helper'
require 'rspec_api_documentation/dsl'

RSpec.resource "User" do
  shared_context "params" do
    parameter "email", scope: :attributes, required: true
    parameter "password", scope: :attributes, required: true
    parameter "name", scope: :attributes, required: true
    parameter "memberships", scope: :relationships
    parameter "organizations", scope: :relationships
  end

  show
  index
  destroy

  create do
    let!(:persisted_organization) { create(:organization) }
    let!(:persisted_membership) { create(:membership, user: current_user) }
    let("email") { "test@example.com" }
    let("password") { "password" }
    let("name") { "Jane Doe" }
    let("organizations") do
      {
        data: [
          {
            id: persisted_organization.id.to_s,
            type: "organizations"
          }
        ]
      }
    end
    let("memberships") do
      {
        data: [
          {
            id: persisted_membership.id.to_s,
            type: "memberships"
          }
        ]
      }
    end
  end

  update do
    let("email") { "new@email.com" }
  end

  get "/v1/users/me", :authenticated, :allowed, :persisted do
    example_request "GET current user" do
      expect(response_status).to eq 200
      expect(parsed_response[:data][:id]).to eq current_user.id.to_s
    end
  end
end
