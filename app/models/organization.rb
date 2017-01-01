# == Schema Information
#
# Table name: organizations
#
#  id         :integer          not null, primary key
#  name       :string           not null
#  address    :text
#  phone      :text
#  url        :string
#  email      :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Organization < ApplicationRecord
  include HasUrl
  include TextSearchable

  search_by_columns :name, :address, :phone, :url, :email

  has_many :memberships

  has_many :users, through: :memberships

  validates :name, presence: true

  validates :email, email: { message: "invalid email format" }, allow_blank: true

  phony_normalize :phone, default_country_code: 'US'

  validates :phone, phone: true, allow_blank: true

  validates :url, url: true, allow_blank: true

  url_normalize :url
end
