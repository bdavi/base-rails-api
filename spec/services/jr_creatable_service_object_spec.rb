require 'rails_helper'

RSpec.describe JRCreatableServiceObject do
  let :fake_class do
    Class.new do
      include JRCreatableServiceObject
    end
  end

  subject do
    fake_class.new
  end

  let(:timestamp) { DateTime.new(2016, 5, 4, 3, 2, 1) }

  before do
    now = double(utc: timestamp)
    allow(DateTime).to receive(:now).and_return(now)
  end

  it { is_expected.to be_kind_of(ActiveModel::Model) }

  describe "#id" do
    it "returns the current timestamp" do
      expect(subject.id).to eq timestamp
    end
  end

  describe "#created_at" do
    it "returns the current timestamp" do
      expect(subject.created_at).to eq timestamp
    end
  end

  describe "#updated_at" do
    it "returns the current timestamp" do
      expect(subject.updated_at).to eq timestamp
    end
  end

  describe "#new_record?" do
    it "returns true" do
      expect(subject.new_record?).to be true
    end
  end

  describe "#save!" do
    it "returns true" do
      expect(subject.save!).to be true
    end
  end

  describe "#perform" do
    it "returns true" do
      expect(subject.perform).to be true
    end
  end

  describe "#can_perform?" do
    it "returns true" do
      expect(subject.can_perform?).to be true
    end
  end

  describe "#valid?" do
    context "when can_perform? is false" do
      it "returns false" do
        allow(subject).to receive(:can_perform?).and_return(false)
        expect(subject.valid?({})).to be false
      end
    end

    context "when #perform raises an error" do
      it "returns false" do
        allow(subject).to receive(:perform).and_raise(ArgumentError)
        expect(subject.valid?({})).to be false
      end
    end
  end
end
