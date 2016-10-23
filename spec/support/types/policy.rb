RSpec.shared_context "policy specs", type: :policy do
  let(:record_class_name) { described_class.name.sub(/Policy\Z/, "") }

  let(:factory_name) { record_class_name.underscore }

  let(:user) { build(:user) }

  let(:record) { build(factory_name) }

  let(:resolved_scope) do
    described_class::Scope.new(user, record_class_name.safe_constantize.all).resolve
  end

  subject { described_class.new(user, record) }

  def self.persist_record_and_user
    before do
      user.save!
      record.save!
    end
  end
end
