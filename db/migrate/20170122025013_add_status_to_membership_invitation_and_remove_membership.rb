class AddStatusToMembershipInvitationAndRemoveMembership < ActiveRecord::Migration[5.0]
  def change
    add_column :membership_invitations, :status, :integer, default: 0, null: false
    remove_reference :membership_invitations, :membership, foreign_key: true
  end
end
