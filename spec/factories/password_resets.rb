FactoryGirl.define do
  factory :password_reset do
    user_id { FactoryGirl.create(:user, password: "OLD_Pass").id }
    old_password "OLD_Pass"
    new_password "NEW_Pass"
  end
end
