# spec/factories/awards.rb
FactoryBot.define do
  factory :award do
    name { "Distinguished Service" }
    award_type { :recognition }
    minimum_service_years { 5 }
    minimum_age { 30 }
    dependent_award_id { nil }
    after(:build) do |award|
      unless Rails.env.production?
        award.image.attach(io: StringIO.new("fake image data"), filename: 'test_image.png', content_type: 'image/png')
      end
    end
  end
end
