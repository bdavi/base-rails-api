FactoryGirl.define do
  factory :user_password_reset_request do
    email Faker::Internet.email
  end
end
