RSpec.shared_context "model specs", type: :model do

  let(:factory_name) { described_class.name.underscore }

  subject { build(factory_name) }

end
