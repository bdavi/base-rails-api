FactoryGirl.define do
  factory :membership_invitation do
    association :user
    association :organization
    sequence(:email) {|n| "some#{n}@email.com" }
  end

  trait :pending

  trait :accepted do
    association :membership
  end

  trait :expired do
    created_at { (MembershipInvitation::EXPIRATION_INTERVAL_DAYS + 1).day.ago }
  end
end
