require 'rails_helper'
require 'rspec_api_documentation/dsl'

RSpec.resource "UserPasswordResetRequest" do
  shared_context "params" do
    parameter "email", scope: :attributes
  end

  create do
    let("email") { Faker::Internet.email }
  end

  post path, :with_params do
    include_context "params"

    example_request "POST create, unauthenticated" do
      expect(response_status).to eq 201
    end
  end
end
