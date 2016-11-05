require 'rails_helper'
require 'rspec_api_documentation/dsl'

RSpec.resource "User" do
  shared_context "user params" do
    parameter "email", scope: :attributes, required: true
    parameter "password", scope: :attributes, required: true
  end

  post "/v1/users", :authenticated, :allowed, :with_params do
    include_context "user params"

    let("email") { "test@example.com" }
    let("password") { "password" }

    example "POST create" do
      do_request
      expect(response_status).to eq 201
    end
  end
end
