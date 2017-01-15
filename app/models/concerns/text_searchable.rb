module TextSearchable
  extend ActiveSupport::Concern

  class_methods do
    def search_by_columns options={}
      scope :search_by, ->(query = "") do
        columns_list = format_search_columns(options[:columns]).join(", ")
        search_terms = query.split(" ")

        conditions = []
        binds = []

        search_terms.each do |term|
          conditions << "concat_ws(' ', #{columns_list}) ILIKE ?"
          binds << "%#{term}%"
        end

        if options[:join]
          left_outer_joins(options[:join]).where(conditions.join(" AND "), *binds).distinct
        else
          where(conditions.join(" AND "), *binds)
        end
      end
    end

    def format_search_columns columns
      columns.map { |column| format_column(column) }
    end

    def format_column column
      if column =~ /\./
        table_name, attribute = column.to_s.split(".")
        "#{table_name.pluralize}.#{attribute}"
      else
        "#{self.table_name}.#{column}"
      end
    end
  end
end
