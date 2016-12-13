module V1
  class PasswordResetResource < ApplicationResource
    attributes :new_password, :old_password, :user_id

    class << self
      def creatable_fields context
        super + %i[new_password old_password user_id]
      end

      def sortable_fields context
        []
      end
    end

    def fetchable_fields
      super + %i[new_password old_password user_id]
    end
  end
end
