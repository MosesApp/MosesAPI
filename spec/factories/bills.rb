FactoryGirl.define do
  factory :bill do
    name { FFaker::HipsterIpsum.word }
    description { FFaker::HipsterIpsum.phrase }
    amount { rand() * 100 + 1 }
    association :group
    association :currency

    trait :model do
      receipt File.new(Rails.root + 'spec/factories/images/enimearecusandae.png')
    end

    trait :controller do
      receipt "data:image/png;base64," + Base64.encode64(
        File.new(Rails.root + 'spec/factories/images/enimearecusandae.png').read )
    end
  end
end
