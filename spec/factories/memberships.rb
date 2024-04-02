FactoryBot.define do
  factory :membership do
    start_date { "2024-04-02" }
    fire_department { nil }
    account { nil }
    role { 1 }
    status { 1 }
  end
end
