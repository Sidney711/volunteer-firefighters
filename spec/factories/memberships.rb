# spec/factories/memberships.rb
FactoryBot.define do
  factory :membership do
    association :fire_department
    association :account
    start_date { Date.today }
    role { "member" }
    status { "active" }
  end
end
