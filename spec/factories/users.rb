FactoryGirl.define do
  factory :user, aliases: [:creator] do
    first_name { FFaker::Name.first_name }
    full_name { FFaker::Name.name }
    email {FFaker::Internet.email}
    facebook_id "100000035613868"
    locale "en_US"
    timezone 1

    trait :model do
      avatar File.new(Rails.root + 'spec/factories/images/enimearecusandae.png')
    end

    trait :controller do
      avatar "data:image/png;base64," + Base64.encode64(
        File.new(Rails.root + 'spec/factories/images/enimearecusandae.png').read )
    end
  end
end
