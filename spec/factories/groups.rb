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

  end
end
