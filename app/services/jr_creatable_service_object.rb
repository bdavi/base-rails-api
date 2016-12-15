module JRCreatableServiceObject
  extend ActiveSupport::Concern
  extend ActiveModel::Callbacks

  included do
    include ActiveModel::Model
  end

  def id
    DateTime.now.utc
  end

  alias_method :created_at, :id

  alias_method :updated_at, :id

  def new_record?
    true
  end

  # Override to actually execute/process service.
  def perform
    true
  end

  # This method is called by JR and and is where we will perform is invoked
  def save options=nil
    perform
  end

  alias_method :save!, :save
end
