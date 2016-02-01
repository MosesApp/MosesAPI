FactoryGirl.define do
  factory :group do
    name { FFaker::HipsterIpsum.word }
    image File.new(Rails.root + 'spec/factories/images/enimearecusandae.png')
    creator
    status "Active"
  end
end
