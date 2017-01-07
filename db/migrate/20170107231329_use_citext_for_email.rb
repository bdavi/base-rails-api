class UseCitextForEmail < ActiveRecord::Migration[5.0]
  def up
    change_column :membership_invitations, :email, :citext
    change_column :organizations, :email, :citext
    change_column :user_password_reset_requests, :email, :citext
  end

  def down
    change_column :membership_invitations, :email, :string
    change_column :organizations, :email, :string
    change_column :user_password_reset_requests, :email, :string
  end
end
