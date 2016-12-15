require 'rails_helper'

RSpec.describe JRCreatableServiceObject do
  let :fake_class do
    Class.new do
      include JRCreatableServiceObject
    end
  end

  let(:timestamp) { DateTime.new(2016, 5, 4, 3, 2, 1) }

  subject { fake_class.new }

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

  describe "#save" do
    it "calls #perform" do
      value = Object.new
      expect(subject).to receive(:perform).and_return(value)
      expect(subject.save({})).to be value
    end
  end

  describe "#perform" do
    it "returns true" do
      expect(subject.perform).to be true
    end
  end
end
