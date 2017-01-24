require 'rails_helper'
require 'rspec_api_documentation/dsl'

RSpec.resource "Organization" do
  shared_context "params" do
    parameter "name", scope: :attributes, required: true
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
    let("address") { "123 Main street, Denver CO 80545"  }
    let("phone") { "9703883888" }
    let("url") { Faker::Internet.url }
    let("email") { Faker::Internet.email }
  end
  update do
    let("address") { "123 Main street, Denver CO 80545" }
  end
  filtered_index :search_by, "iS tHe"  do
    let!(:matching_record) { create(:organization, name: "This is the name") }
    let!(:not_matching_record) { create(:organization) }
  end
end
