FactoryGirl.define do
  factory :membership do
    association :user
    association :organization
  end
end
