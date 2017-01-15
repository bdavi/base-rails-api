FactoryGirl.define do
  factory :membership_invitation do
    association :user
    association :organization
    sequence(:email) {|n| "some#{n}@email.com" }
  end
end
