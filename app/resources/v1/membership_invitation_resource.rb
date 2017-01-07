module V1
  class MembershipInvitationResource < ApplicationResource
    attribute :email

    has_one :user

    has_one :membership

    has_one :organization

    class << self
      def creatable_fields context
        super + %i[user email membership organization]
      end

      def updatable_fields context
        super + %i[user email membership organization]
      end
    end

    def fetchable_fields
      super + %i[user email membership organization]
    end
  end
end
