module V1
  class UserPasswordResetRequestsController < V1::ResourceController
    # Allow unauthenticated users to request password reset
    skip_before_action :doorkeeper_authorize!
  end
end
