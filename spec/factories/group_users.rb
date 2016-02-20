FactoryGirl.define do
  factory :group_user do
    is_admin { FFaker::Boolean.random }
    association :user
    association :group
  end
end
