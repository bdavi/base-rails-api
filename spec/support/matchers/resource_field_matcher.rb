module ResourceSpecHelpers
  class ResouceFieldMatcher
    def initialize field_kind_name, method_kind, *expected
      @field_kind_name = field_kind_name
      @expected = expected
      @method_kind = method_kind
    end

    def matches?(resource)
      @resource = resource

      case @method_kind
      when :instance
        @actual = resource.public_send("#{@field_kind_name}_fields")
      when :class
        @actual = resource.class.public_send("#{@field_kind_name}_fields", {})
      else
        raise ArgumentError, "method_kind must be :instance or :class"
      end

      @actual.to_set == @expected.to_set
    end

    def failure_message
      "Expected #{@resource.class.name} #{@field_kind_name} fields to be #{@expected} but was #{@actual}."
    end

    def description
      if @expected.any?
        "have #{@field_kind_name} fields: #{@expected}"
      else
        "have no #{@field_kind_name} fields"
      end
    end
  end

  %i[sortable updatable creatable].each do |kind|
    define_method "have_#{kind}_fields" do |*fields|
      ResouceFieldMatcher.new(kind, :class, *fields)
    end

    define_method "have_no_#{kind}_fields" do
      ResouceFieldMatcher.new(kind, :class, [])
    end
  end

  def have_fetchable_fields *fields
    ResouceFieldMatcher.new(:fetchable, :instance, *fields)
  end

  def have_no_fetchable_fields
    have_fetchable_fields
  end
end
