class MembershipPolicy < ApplicationPolicy

  def create?
    Pundit.policy!(user, record.organization).update?
  end

  def update?
    false
  end

  alias destroy? create?

  class Scope < Scope
    def resolve
      scope.where(organization_id: scope_for(Organization).select(:id))
    end
  end
end
