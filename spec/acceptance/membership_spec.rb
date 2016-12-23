require 'rails_helper'
require 'rspec_api_documentation/dsl'

RSpec.resource "Membership" do
  shared_context "params" do
    parameter "user", scope: :relationships
    parameter "organization", scope: :relationships
  end

  show
  index
  destroy
  create do
    let!("user") do
      {
        data: {
          id: create(:user).id.to_s,
          type: "users"
        }
      }
    end
    let!("organization") do
      {
        data: {
          id: create(:organization).id.to_s,
          type: "organizations"
        }
      }
    end
  end
end
