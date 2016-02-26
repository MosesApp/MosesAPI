FactoryGirl.define do
  factory :group do
    name { FFaker::HipsterIpsum.word }
    status {["Active", "Inactive"].sample }
    association :creator, factory: :user

    trait :model do
      avatar File.new(Rails.root + 'spec/factories/images/enimearecusandae.png')
    end

    trait :controller do
      creator_id 1
      avatar "data:image/png;base64," + Base64.encode64(
        File.new(Rails.root + 'spec/factories/images/enimearecusandae.png').read )
    end

    factory :group_with_users do
      transient do
        user_count 3
      end

      after(:create) do |group, evaluator|
        create_list(:group_user, evaluator.user_count, group: group)
      end
    end

    factory :group_with_bills do
      transient do
        user_count 3
        bill_count 3
      end

      after(:create) do |group, evaluator|
        create_list(:group_user, evaluator.user_count, group: group)
        create_list(:bill, evaluator.bill_count, group: group)
      end
    end

  end
end
