FactoryGirl.define do
  factory :user_password_reset_request do
    email { create(:user).email }
  end
end
