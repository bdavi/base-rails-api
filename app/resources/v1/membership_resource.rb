module V1
  class MembershipResource < ApplicationResource
    has_one :user

    has_one :organization

    filter :organization

    filter :search_by, apply: -> (records, value, _options) {
      records.search_by(value)
    }

    class << self
      def creatable_fields context
        super + %i[user organization]
      end

      alias updatable_fields creatable_fields

      def sortable_fields context
        super + %i[user.name]
      end
    end

    def fetchable_fields
      super + %i[user organization]
    end
  end
end
