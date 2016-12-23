require 'rails_helper'
require 'rspec_api_documentation/dsl'

RSpec.resource "Organization" do
  shared_context "params" do
    parameter "name", scope: :attributes
    parameter "address", scope: :attributes
    parameter "phone", scope: :attributes
    parameter "url", scope: :attributes
    parameter "email", scope: :attributes
  end

  show
  index
  destroy
  create do
    let("name") { Faker::Company.name }
    let("address") { Faker::Address.street_address  }
    let("phone") { Faker::PhoneNumber.cell_phone }
    let("url") { Faker::Internet.url }
    let("email") { Faker::Internet.email }
  end
  update do
    let("url") { Faker::Internet.url }
  end
end
