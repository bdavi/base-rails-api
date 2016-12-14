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

  # This method is called by JR and and is where we will perform the service
  def valid? context
    return false unless can_perform?

    begin
      perform
    rescue
      false
    end
  end

  # Override to actually execute service. Return true on success.
  # On failure, return false or raise error.
  def perform
    true
  end

  # Override to prevent service from executing. Return false
  # to prevent SO from executing. Use to validate conditions
  # are correct to perform service.
  def can_perform?
    true
  end
end
