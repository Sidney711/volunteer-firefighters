# spec/factories/account_awards.rb
FactoryBot.define do
  factory :account_award do
    association :account
    association :award
  end
end
