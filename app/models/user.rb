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
#
# Indexes
#
#  index_users_on_email  (email) UNIQUE
#

class User < ApplicationRecord
  has_secure_password

  validates :email,
    presence: true,
    uniqueness: { case_insensitive: true },
    email: { message: "invalid email format" }

  validates :name, presence: true

  def access_token
    expires_in = Doorkeeper.configuration.authorization_code_expires_in
    Doorkeeper::AccessToken.find_or_create_for(nil, id, nil, expires_in, false)
  end
end
