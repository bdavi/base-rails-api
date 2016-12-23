module V1
  class OrganizationResource < ApplicationResource
    attribute :name

    attribute :address

    attribute :phone

    attribute :url

    attribute :email

    has_many :memberships

    has_many :users

    class << self
      def creatable_fields context
        super + %i[name address phone url email memberships users]
      end

      alias updatable_fields creatable_fields
    end

    def fetchable_fields
      super + %i[name address phone url email memberships users]
    end
  end
end
