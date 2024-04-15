FactoryBot.define do
  factory :account do
    email { Faker::Internet.email }
    password_hash { BCrypt::Password.create('password123') }
    full_name { Faker::Name.name }
    birth_date { Faker::Date.birthday(min_age: 18, max_age: 65) }
    phone { Faker::PhoneNumber.phone_number }
    member_code { Faker::Alphanumeric.alphanumeric(number: 10, min_alpha: 1, min_numeric: 1) }
    is_super_admin { false }
    status { 2 }
  end
end