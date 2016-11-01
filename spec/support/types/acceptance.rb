RSpec.shared_context "acceptance specs", type: :acceptance do
  def parsed_response
    JSON.parse(response_body, symbolize_names: true)
  end
end

RSpec.shared_context "authenticated", authenticated: true do
  let! :current_user do
    FactoryGirl.create(:user)
  end

  let!(:user_token) { Doorkeeper::AccessToken.create(resource_owner_id: current_user.id) }

  let :bearer do
    "Bearer #{user_token.token}"
  end

  header "Authorization", :bearer
end

RSpec.shared_context "with params", type: :with_params do
  header "Content-Type", "application/vnd.api+json"
end
