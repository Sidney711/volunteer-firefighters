# spec/factories/fire_departments.rb
FactoryBot.define do
  factory :fire_department do
    name { Faker::Company.name }
    code { Faker::Alphanumeric.alpha(number: 10) }
    address { Faker::Address.full_address }
    district
  end
end
