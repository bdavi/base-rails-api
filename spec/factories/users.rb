FactoryGirl.define do
  factory :user do
    sequence(:email) { |n| "example#{n}@test.com"}
    name Faker::Name.name
    password "Password123"
  end
end
