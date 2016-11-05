RSpec.shared_context "acceptance specs", type: :acceptance do
  def parsed_response
    JSON.parse(response_body, symbolize_names: true)
  end

  let(:model_class_name) { example.metadata[:resource_name] }

  let(:model_class) { model_class_name.safe_constantize }

  let(:policy_class_name) { "#{model_class_name}Policy" }

  let(:policy_class) { policy_class_name.safe_constantize }
end

RSpec.shared_context "authenticated", authenticated: true do
  let!(:current_user) { FactoryGirl.create(:user) }

  let!(:user_token) { Doorkeeper::AccessToken.create(resource_owner_id: current_user.id) }

  let(:bearer) { "Bearer #{user_token.token}" }

  header "Authorization", :bearer
end

RSpec.shared_context "with params", with_params: true do
  header "Content-Type", "application/vnd.api+json"

  parameter "type", required: true

  let("type") { model_class_name.pluralize.underscore.dasherize }
end

RSpec.shared_context "allowed", allowed: true do
  before do
    %i[create? update? destroy?].each do |permission|
      allow_any_instance_of(policy_class).to receive(permission).and_return(true)
    end

    allow(Pundit).to receive(:policy_scope!) {|_, scope| scope.all }
  end
end
