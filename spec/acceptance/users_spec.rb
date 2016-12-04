require 'rails_helper'
require 'rspec_api_documentation/dsl'

RSpec.resource "User" do
  shared_context "params" do
    parameter "email", scope: :attributes, required: true
    parameter "password", scope: :attributes, required: true
    parameter "name", scope: :attributes, required: true
  end

  show
  index
  destroy

  create do
    let("email") { "test@example.com" }
    let("password") { "password" }
    let("name") { "Jane Doe" }
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
