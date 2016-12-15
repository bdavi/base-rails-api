class PasswordReset
  include JRCreatableServiceObject

  attr_accessor :new_password, :old_password, :user_id

  validates :old_password, presence: true

  validates :new_password, presence: true

  validates :user_id, presence: true

  validate :_validate_old_password_is_for_user

  def perform
    _user.update password: new_password
  end

  private

  def _validate_old_password_is_for_user
    unless _user&.authenticate(old_password)
      errors.add :old_password, "does not match user"
    end
  end

  def _user
    return unless user_id
    User.find(user_id)
  end
end
