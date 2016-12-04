class EndPointGenerator < Rails::Generators::NamedBase
  source_root File.expand_path('../templates', __FILE__)

  def create_model
    generate "model", ARGV.join(" ")
    template "model_spec_template.erb", "spec/models/#{file_name}_spec.rb", force: true
  end

  def create_policy
    template "policy_template.erb", "app/policies/#{file_name}_policy.rb"
    template "policy_spec_template.erb", "spec/policies/#{file_name}_policy_spec.rb"
  end

  def create_resource
    template "resource_template.erb", "app/resources/v1/#{file_name}_resource.rb"
    template "resource_spec_template.erb", "spec/resources/v1/#{file_name}_resource_spec.rb"
  end

  def create_controller
    template "controller_template.erb", "app/controllers/v1/#{file_name.pluralize}_controller.rb"
  end

  def create_route
    gsub_file "config/routes.rb", "  namespace :v1 do",
      "  namespace :v1 do\n    jsonapi_resources :#{class_name.underscore.pluralize}"
  end

  def create_acceptance_spec
    template "acceptance_spec_template.erb", "spec/acceptance/#{file_name}_spec.rb"
  end

  private

  def attribute_name value
    value.include?(":") ? value.split(":").first : value
  end

  def attribute_names
    args.map { |arg| attribute_name(arg) }
  end

  def belongs_to_attribute_names
    args.grep(/:belongs_to\Z/).map {|arg| attribute_name(arg) }
  end

  def non_belongs_to_attribute_names
    attribute_names - belongs_to_attribute_names
  end
end
