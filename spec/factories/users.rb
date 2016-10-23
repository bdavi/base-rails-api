FactoryGirl.define do
  factory :user do
    sequence(:email) { |n| "example#{n}@test.com"}
    password_digest "The Digest"
  end
end
