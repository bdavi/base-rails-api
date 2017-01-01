module TextSearchable
  extend ActiveSupport::Concern

  class_methods do
    def search_by_columns *columns
      scope :search_by, ->(query = "") do
        columns_list = columns.join(", ")
        search_terms = query.split(" ")

        conditions = []
        binds = []

        search_terms.each do |term|
          conditions << "concat_ws(' ', #{columns_list}) ILIKE ?"
          binds << "%#{term}%"
        end

        where(conditions.join(" AND "), *binds)
      end
    end
  end
end
