module V1
  class ApplicationResource < JSONAPI::Resource
    attributes :created_at, :updated_at

    class << self
      def creatable_fields context
        []
      end

      def updatable_fields context
        []
      end

      def sortable_fields context
        %i[id created_at updated_at]
      end
    end

    def fetchable_fields
      %i[id created_at updated_at]
    end
  end
end
