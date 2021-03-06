module V1
  class ResourceController < JSONAPI::ResourceController
    include Pundit::ResourceController
    include Doorkeeper::Rails::Helpers
    include ActionController::Head

    before_action :doorkeeper_authorize!

    protected

    def current_user
      User.find(doorkeeper_token.resource_owner_id) if doorkeeper_token
    end
  end
end
