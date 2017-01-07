class MembershipInvitationPolicy < ApplicationPolicy
  def create?
    user.application_admin? ||
      record.organization.users.include?(user)
  end

  def update?
    create?
  end

  def destroy?
    create?
  end

  class Scope < Scope
    def resolve
      if user.application_admin?
        return scope.all
      end

      scope.where(organization_id: scope_for(Organization).select(:id))
    end
  end
end
