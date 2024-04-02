FactoryBot.define do
  factory :award do
    name { "MyString" }
    award_type { 1 }
    image { "MyString" }
    dependent_award_id { 1 }
    minimum_service_years { 1 }
    minimum_age { 1 }
  end
end
