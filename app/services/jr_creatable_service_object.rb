module JRCreatableServiceObject
  extend ActiveSupport::Concern
  include ActiveModel::Model

  def id
    DateTime.now.utc
  end

  alias_method :created_at, :id

  alias_method :updated_at, :id

  def new_record?
    true
  end

  def save!
    true
  end
end
