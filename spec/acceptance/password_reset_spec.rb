require 'rails_helper'
require 'rspec_api_documentation/dsl'

RSpec.resource "PasswordReset" do
  shared_context "params" do
    parameter "old-password", scope: :attributes, required: true
    parameter "new-password", scope: :attributes, required: true
    parameter "user-id", scope: :attributes, required: true
  end

  create do
    let("old-password") { "OLD_pass" }
    let("new-password") { "NEW_pass" }
    let!(:current_user) { create(:user, password: old_password) }
    let("user-id") { current_user.id }
  end
end
