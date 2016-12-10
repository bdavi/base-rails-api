module V1
  class UserResource < ApplicationResource
    attributes :email, :password, :name

    class << self
      def creatable_fields context
        super + %i[email password name]
      end

      def updatable_fields context
        super + %i[email name]
      end

      def sortable_fields context
        super + %i[email name]
      end
    end

    def fetchable_fields
      super + %i[email name]
    end
  end
end
