module V1
  class UserResource < ApplicationResource
    attributes :email, :password

    class << self
      def creatable_fields context
        super + %i[email password]
      end

      def updatable_fields context
        super + %i[email password]
      end

      def sortable_fields context
        super + %i[email]
      end
    end

    def fetchable_fields
      super + %i[email]
    end
  end
end
