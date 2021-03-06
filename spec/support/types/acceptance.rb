RSpec.shared_context "acceptance specs", type: :acceptance do
  def parsed_response
    JSON.parse(response_body, symbolize_names: true)
  end

  let(:model_class_name) { example.metadata[:resource_name] }

  let(:model_class) { model_class_name.safe_constantize }

  let(:policy_class_name) { "#{model_class_name}Policy" }

  let(:policy_class) { policy_class_name.safe_constantize }

  let(:factory_name) { model_class_name.underscore }

  class << self
    def path
      "/v1/#{metadata[:resource_name].pluralize.underscore.dasherize}/"
    end

    def show
      get "#{path}:persisted_id", :authenticated, :allowed, :persisted do
        example_request "GET show" do
          expect(response_status).to eq 200
        end
      end
    end

    def index
      get path, :authenticated, :allowed, :persisted do
        example_request "GET index" do
          expect(response_status).to eq 200
        end
      end
    end

    def filtered_index filter, filter_value, &block
      get path, :authenticated, :allowed do
        yield if block_given?

        example "GET index(filter: #{filter})" do
          do_request({ filter: { filter => filter_value}})
          expect(response_status).to eq 200
          expect(parsed_response[:data].size).to eq 1
          expect(parsed_response[:data].first[:id]).to eq matching_record.id.to_s
        end
      end
    end

    def destroy
      delete "#{path}:persisted_id", :authenticated, :allowed, :persisted, :persisted_id do
        example_request "DELETE destroy" do
          expect(response_status).to eq 204
        end
      end
    end

    def create &block
      post path, :authenticated, :allowed, :with_params do
        include_context "params"
        yield if block_given?
        example_request "POST create" do
          expect(response_status).to eq 201
        end
      end
    end

    def update &block
      patch "#{path}:persisted_id", :authenticated, :allowed, :with_params, :persisted_id, :persisted do
        include_context "params"
        yield if block_given?
        example_request "PATCH update" do
          expect(response_status).to eq 200
        end
      end
    end
  end
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

RSpec.shared_context "persisted id", persisted_id: true do
  parameter "id", required: true

  let("id") { persisted_id }
end

RSpec.shared_context "persisted", persisted: true do
  let!(:persisted) { FactoryGirl.create(factory_name.to_sym) }

  let(:persisted_id) { persisted.id }
end
