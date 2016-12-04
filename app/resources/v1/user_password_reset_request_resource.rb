module V1
  class UserPasswordResetRequestResource < ApplicationResource
    attribute :email

    class << self
      def creatable_fields context
        %i[email]
      end

      def sortable_fields context
        []
      end
    end

    def fetchable_fields
      []
    end
  end
end
