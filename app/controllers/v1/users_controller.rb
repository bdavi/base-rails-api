module V1
  class UsersController  < V1::ResourceController
    skip_before_action :doorkeeper_authorize!, only: [:create]

    prepend_before_action :_replace_me_with_current_user_id, only: [:show]

    private

    def _replace_me_with_current_user_id
      return unless current_user
      return unless params[:id] == "me"

      params[:id] = current_user.id.to_s
    end
  end
end
