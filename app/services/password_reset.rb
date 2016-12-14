class PasswordReset
  include JRCreatableServiceObject

  attr_accessor :new_password, :old_password, :user_id

  def perform
    user.update password: new_password
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
end
