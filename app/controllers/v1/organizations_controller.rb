module V1
  class OrganizationsController < V1::ResourceController
    skip_before_action :doorkeeper_authorize!, only: [:create]
  end
end
