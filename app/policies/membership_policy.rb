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
      organization_ids = scope_for(Organization).select(:id)
      scope.where(organization_id: organization_ids)
    end
  end
end
