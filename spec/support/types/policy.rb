RSpec.shared_context "policy specs", type: :policy do
  subject { described_class.new(user, record) }
end
