class UserPolicy < ApplicationPolicy
  def create?
    true
  end

  def update?
    case
    when non_admin_user_is_changing_kind? then false
    when user.application_admin? then true
    when user_and_record_share_a_membership then true
    when user == record then true
    else false
    end
  end

  def destroy?
    update?
  end

  class Scope < Scope
    def resolve
      return scope.all if user.application_admin? # handle users with no memberships

      conditions = [
        "users.id = ?",
        "memberships.organization_id IN (#{scope_for(Organization).select(:id).to_sql})"
      ]

      scope
        .left_outer_joins(:memberships)
        .where(conditions.join(" OR "), user.id)
    end
  end

  private

  def non_admin_user_is_changing_kind?
    if user == record
      return user.kind_changed? && user.kind_was == "standard"
    end
    !user.application_admin? && record.kind_changed?
  end

  def user_and_record_share_a_membership
    (user.organizations & record.organizations).any?
  end
end
