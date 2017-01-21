# == Schema Information
#
# Table name: memberships
#
#  id              :integer          not null, primary key
#  user_id         :integer          not null
#  organization_id :integer          not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#
# Indexes
#
#  index_memberships_on_organization_id  (organization_id)
#  index_memberships_on_user_id          (user_id)
#
# Foreign Keys
#
#  fk_rails_64267aab58  (organization_id => organizations.id)
#  fk_rails_99326fb65d  (user_id => users.id)
#

class Membership < ApplicationRecord
  include TextSearchable

  search_by_columns columns: %i[user.email user.name], join: :user

  belongs_to :user, required: true

  belongs_to :organization, required: true

  has_many :membership_invitations, dependent: :nullify

end
