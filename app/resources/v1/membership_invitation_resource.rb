module V1
  class MembershipInvitationResource < ApplicationResource
    attribute :email

    attribute :status

    has_one :invited_user, class_name: "User"

    has_one :user

    has_one :membership

    has_one :organization

    filter :organization

    filter :search_by, apply: -> (records, value, _options) {
      records.search_by(value)
    }

    filter :status, apply: -> (records, values, _options) {
      # Uses enum scopes
      values.map {|status| records.send(status) }.reduce(&:or)
    }

    class << self
      def creatable_fields context
        super + %i[user email membership organization]
      end

      def updatable_fields context
        super + %i[user email membership organization]
      end
    end

    def fetchable_fields
      super + %i[user email membership organization status invited_user]
    end
  end
end
