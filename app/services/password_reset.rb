class PasswordReset
  include JRCreatableServiceObject

  attr_accessor :new_password, :old_password, :user_id

  def perform
    raise JSONAPI::Exceptions::InternalServerError, "Invalid Password Reset" unless can_perform?
    reset_user_password
  end

  def can_perform?
    new_password && old_password_is_for_user
  end

  def old_password_is_for_user
    user&.authenticate(old_password)
  end

  def user
    return unless user_id
    User.find(user_id)
  end

  def reset_user_password
    user.update password: new_password
  end
end
