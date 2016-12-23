module V1
  class MembershipResource < ApplicationResource
    has_one :user

    has_one :organization

    class << self
      def creatable_fields context
        super + %i[user organization]
      end

      alias updatable_fields creatable_fields
    end

    def fetchable_fields
      super + %i[user organization]
    end
  end
end
