module V1
  class MembershipInvitationResource < ApplicationResource
    attribute :email

    attribute :status

    has_one :user

    has_one :membership

    has_one :organization

    class << self
      def creatable_fields context
        super + %i[user email membership organization status]
      end

      def updatable_fields context
        super + %i[user email membership organization status]
      end
    end

    def fetchable_fields
      super + %i[user email membership organization status]
    end
  end
end
