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
end
