FactoryGirl.define do
  factory :membership_invitation do
    association :user
    association :organization
    email "some@email.com"
  end
end
