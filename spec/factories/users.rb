FactoryGirl.define do
  factory :user, aliases: [:creator] do
    first_name { FFaker::Name.first_name }
    full_name { FFaker::Name.name }
    email { FFaker::Internet.email }
    sequence(:facebook_id) { |n| "1000012523367#{n}" }
    locale "en_US"
    timezone 1

    trait :model do
      avatar File.new(Rails.root + 'spec/factories/images/enimearecusandae.png')
    end

    trait :controller do
      avatar "data:image/png;base64," + Base64.encode64(
        File.new(Rails.root + 'spec/factories/images/enimearecusandae.png').read )
    end

    factory :user_with_groups do
      transient do
        group_count 2
      end

      after(:create) do |user, evaluator|
        create_list(:group_user, evaluator.group_count, user: user)
      end
    end

  end
end
