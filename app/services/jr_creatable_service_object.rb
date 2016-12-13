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

  # This method performs the service, should return true when successful.
  # Override in classes including this module.
  # Raise an exception on failure, i.e. `raise JSONAPI::Exceptions::InternalServerError`
  def perform
    true
  end

  # JR will call save! on the object during POST/create.
  # We want the object to perform its service at that time.
  alias_method :save!, :perform
end
