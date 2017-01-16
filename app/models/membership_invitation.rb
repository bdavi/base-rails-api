# == Schema Information
#
# Table name: membership_invitations
#
#  id              :integer          not null, primary key
#  user_id         :integer          not null
#  email           :citext           not null
#  membership_id   :integer
#  organization_id :integer          not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#
# Indexes
#
#  index_membership_invitations_on_membership_id    (membership_id)
#  index_membership_invitations_on_organization_id  (organization_id)
#  index_membership_invitations_on_user_id          (user_id)
#
# Foreign Keys
#
#  fk_rails_2d5610504b  (organization_id => organizations.id)
#  fk_rails_b0fb0efd47  (user_id => users.id)
#  fk_rails_d1d8e48c20  (membership_id => memberships.id)
#

class MembershipInvitation < ApplicationRecord
  include TextSearchable

  EXPIRATION_INTERVAL_DAYS = 30

  belongs_to :user

  belongs_to :membership

  belongs_to :organization

  validates :email,
    presence: true,
    email: { message: "invalid email format" }

  validates :organization, presence: true

  validates :user, presence: true

  validate :_validate_invited_user_does_not_have_existing_membership,
    if: :invited_user, on: :create

  validate :_validate_email_does_not_have_a_pending_invitation_to_this_organization,
    on: :create

  after_create :accept, if: :invited_user

  after_create :_email_existing_user, if: :invited_user

  after_create :_email_invitation_to_new_user, unless: :invited_user

  search_by_columns columns: %i[email user.name], join: :user

  scope :pending, ->() {
    where(membership: nil)
      .where("created_at > ?", EXPIRATION_INTERVAL_DAYS.days.ago)
  }

  def accept
    return unless invited_user && organization && !membership

    new_membership = Membership.create(user: invited_user, organization: organization)
    self.update membership: new_membership
  end

  def status
    return "accepted" if membership
    return "expired" if created_at < EXPIRATION_INTERVAL_DAYS.days.ago
    return "pending"
  end

  def invited_user
    User.find_by(email: email)
  end

  private

  def _email_existing_user
    return unless invited_user && organization

    MembershipInvitationMailer.added_to_new_organization_email(self).deliver_later
  end

  def _email_invitation_to_new_user
    return if invited_user || membership

    MembershipInvitationMailer.invite_user_email(self).deliver_later
  end

  def _validate_invited_user_does_not_have_existing_membership
    return unless invited_user && organization

    if invited_user.organizations.include?(organization)
      errors.add :email, "A user with this email already has a membership with the organization."
    end
  end

  def _validate_email_does_not_have_a_pending_invitation_to_this_organization
    return unless email && organization

    if MembershipInvitation.pending.exists?(email: email, organization: organization)
      errors.add :email, "already has a pending invitation to this organization"
    end
  end
end
