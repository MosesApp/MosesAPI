FactoryGirl.define do
  factory :user, aliases: [:creator] do
    first_name { FFaker::Name.first_name }
    full_name { FFaker::Name.name }
    email {FFaker::Internet.email}
    facebook_id "100000035613868"
    locale "en_US"
    timezone 1
  end
end
