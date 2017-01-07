class CreateMembershipInvitations < ActiveRecord::Migration[5.0]
  def change
    create_table :membership_invitations do |t|
      t.belongs_to :user, foreign_key: true, null: false
      t.string :email, null: false
      t.belongs_to :membership, foreign_key: true
      t.belongs_to :organization, foreign_key: true, null:false

      t.timestamps
    end
  end
end
