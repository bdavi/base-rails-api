class UserPasswordResetRequestPolicy < ApplicationPolicy
  def create?
    true
  end

  def update?
    false
  end

  alias_method :destroy?, :update?

  class Scope < Scope
    def resolve
      scope.none
    end
  end
end
