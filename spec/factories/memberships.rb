FactoryBot.define do
  factory :membership do
    start_date { "2024-04-02" }
    fire_department { nil }
    member { nil }
    role { "MyString" }
    status { "MyString" }
  end
end
