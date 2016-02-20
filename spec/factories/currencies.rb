FactoryGirl.define do
  factory :currency do
    prefix '$'
    code { FFaker::Currency.code }
    description { FFaker::Currency.name }
  end
end
