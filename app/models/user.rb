# == Schema Information
#
# Table name: users
#
#  id              :integer          not null, primary key
#  email           :citext           not null
#  password_digest :text             not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  name            :string           not null
#  kind            :integer          default("standard"), not null
#
# Indexes
#
#  index_users_on_email  (email) UNIQUE
#

class User < ApplicationRecord
  has_many :memberships, dependent: :destroy

  has_many :organizations, through: :memberships

  has_secure_password

  validates :email,
    presence: true,
    uniqueness: { case_insensitive: true },
    email: { message: "invalid email format" }

  validates :name, presence: true

  enum kind: [:application_admin, :standard]

  after_create :_accept_pending_invitations, on: :commit

  def access_token
    expires_in = Doorkeeper.configuration.authorization_code_expires_in
    Doorkeeper::AccessToken.find_or_create_for(nil, id, nil, expires_in, false)
  end

  private

  def _accept_pending_invitations
    _pending_invitations.each {|invitation| invitation.accept }
  end

  def _pending_invitations
    MembershipInvitation.pending.where(email: email)
  end
end
