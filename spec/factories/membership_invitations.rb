FactoryGirl.define do
  factory :membership_invitation do
    association :user
    association :organization
    sequence(:email) {|n| "some#{n}@email.com" }
  end

  trait :pending do
    status "pending"
  end

  trait :accepted do
    status "accepted"
  end

  trait :expired do
    status "expired"
  end
end
