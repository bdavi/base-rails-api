RSpec.shared_context "resource specs", type: :resource do
  include ResourceSpecHelpers

  let(:model_class_name) do
    described_class.name.split("::").last.sub(/Resource\Z/, "")
  end

  let(:model_class) { model_class_name.safe_constantize }

  let(:factory_name) { model_class_name.underscore }

  let(:context) { {} }

  let(:record) { create(factory_name) }

  subject { described_class.new(record, context) }
end
