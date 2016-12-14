require 'rails_helper'
require 'rspec_api_documentation/dsl'

RSpec.resource "PasswordReset" do
  shared_context "params" do
    parameter "old-password", scope: :attributes, required: true
    parameter "new-password", scope: :attributes, required: true
    parameter "user-id", scope: :attributes, required: true
  end

  create do
    let("old-password") { "Password123" }
    let("new-password") { "NEW_pass" }
    let!(:current_user) { create(:user) }
    let("user-id") { current_user.id }
    before do
      current_user.reload
    end
  end
end
