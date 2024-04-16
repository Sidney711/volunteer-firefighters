# spec/factories/districts.rb
FactoryBot.define do
  factory :district do
    name { Faker::Address.community }
    code { Faker::Alphanumeric.alpha(number: 10) }
    region
  end
end
