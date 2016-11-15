module V1
  class UsersController  < V1::ResourceController
    skip_before_action :doorkeeper_authorize!, only: [:create]

    prepend_before_action :handle_me_parameter, only: [:show]

    def handle_me_parameter
      return unless current_user
      return unless params[:id] == "me"

      params[:id] = current_user.id.to_s
    end
  end
end
