class OrganizationPolicy < ApplicationPolicy
  def create?
    true
  end

  def update?
    user&.application_admin? || user&.organizations&.include?(record)
  end

  alias destroy? update?

  class Scope < Scope
    def resolve
      return scope.all if user&.application_admin?

      organization_ids = user.memberships.select(:organization_id)
      scope.where(id: organization_ids)
    end
  end
end
