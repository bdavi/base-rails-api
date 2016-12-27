module V1
  class UserResource < ApplicationResource
    attributes :email, :password, :name

    has_many :organizations

    has_many :memberships

    class << self
      def creatable_fields context
        super + %i[email password name memberships organizations]
      end

      def updatable_fields context
        super + %i[email name memberships organizations]
      end

      def sortable_fields context
        super + %i[email name]
      end
    end

    def fetchable_fields
      super + %i[email name memberships organizations]
    end
  end
end
