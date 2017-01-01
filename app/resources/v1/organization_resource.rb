module V1
  class OrganizationResource < ApplicationResource
    attribute :name

    attribute :address

    attribute :phone

    attribute :url

    attribute :email

    has_many :memberships

    has_many :users

    filter :search_by, apply: -> (records, value, _options) {
      records.search_by(value)
    }

    class << self
      def creatable_fields context
        super + %i[name address phone url email memberships users]
      end

      alias updatable_fields creatable_fields

      def sortable_fields context
        super + %i[name]
      end
    end

    def fetchable_fields
      super + %i[name address phone url email memberships users]
    end
  end
end
