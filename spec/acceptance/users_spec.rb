require 'rails_helper'
require 'rspec_api_documentation/dsl'

RSpec.resource "User" do
  ROUTE = "/v1/users/"

  shared_context "params" do
    parameter "email", scope: :attributes, required: true
    parameter "password", scope: :attributes, required: true
  end

  show
  index
  destroy
  create do
    let("email") { "test@example.com" }
    let("password") { "password" }
  end
  update do
    let("email") { "new@email.com" }
  end
end
