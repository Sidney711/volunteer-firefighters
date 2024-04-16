# spec/factories/regions.rb
FactoryBot.define do
  factory :region do
    name { Faker::Address.state }
    code { Faker::Alphanumeric.alpha(number: 10) }

    # Optional: define associations if needed
    # districts { build_list :district, 3 }
  end
end
