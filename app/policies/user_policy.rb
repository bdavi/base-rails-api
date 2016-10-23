class UserPolicy < ApplicationPolicy
  def create?
    true
  end

  def update?
    user == record
  end

  def destroy?
    update?
  end

  class Scope < Scope
    def resolve
      scope.where(id: user.id)
    end
  end
end
