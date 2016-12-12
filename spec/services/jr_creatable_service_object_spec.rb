require 'rails_helper'

RSpec.describe JRCreatableServiceObject do
  subject do
    Class.new do
      include JRCreatableServiceObject
    end
  end

  let(:timestamp) { DateTime.new(2016, 5, 4, 3, 2, 1) }

  before do
    now = double(utc: timestamp)
    allow(DateTime).to receive(:now).and_return(now)
  end

  describe "#id" do
    it "returns the current timestamp" do
      expect(subject.new.id).to eq timestamp
    end
  end

  describe "#created_at" do
    it "returns the current timestamp" do
      expect(subject.new.created_at).to eq timestamp
    end
  end

  describe "#updated_at" do
    it "returns the current timestamp" do
      expect(subject.new.updated_at).to eq timestamp
    end
  end

  describe "#new_record?" do
    it "returns true" do
      expect(subject.new.new_record?).to be true
    end
  end

  describe "#save!" do
    it "returns true" do
      expect(subject.new.save!).to be true
    end
  end
end
